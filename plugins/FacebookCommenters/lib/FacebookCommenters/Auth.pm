# Copyright (C) 2008 Six Apart, Ltd. All Rights Reserved.
#
# Licensed under the same terms as Perl itself.
package FacebookCommenters::Auth;
use strict;
use warnings;

my $PluginKey = 'FacebookCommenters';

sub instance {
    my ($app) = @_;
    $app ||= 'MT';
    $app->component($PluginKey);
}

sub condition {
    my ( $blog, $reason ) = @_;
    return 1 unless $blog;
    my $plugin  = instance();
    my $blog_id = $blog->id;
    my $facebook_api_key
        = $plugin->get_config_value( 'facebook_app_key', "blog:$blog_id" );
    my $facebook_api_secret
        = $plugin->get_config_value( 'facebook_app_secret', "blog:$blog_id" );
    return 1 if $facebook_api_key && $facebook_api_secret;
    $$reason
        = '<a href="?__mode=cfg_plugins&amp;blog_id='
        . $blog->id . '">'
        . $plugin->translate('Set up Facebook Commenters plugin') . '</a>';
    return 0;
}

sub commenter_auth_params {
    my ( $key, $blog_id, $entry_id, $static ) = @_;
    require MT::Util;
    if ( $static =~ m/^http%3A%2F%2F/ ) {

        # the URL was encoded before, but we want the normal version
        $static = MT::Util::decode_url($static);
    }
    my $params = {
        blog_id => $blog_id,
        static  => $static,
    };
    $params->{entry_id} = $entry_id if defined $entry_id;
    return $params;
}

sub __create_return_url {
    my $app = shift;
    my $q   = $app->param;
    my $cfg = $app->config;

    my $blog_id = $q->param("blog_id");
    $blog_id =~ s/\D//g;
    my $static = $q->param("static");

    my @params = (
        "__mode=handle_sign_in", "key=Facebook", "blog_id=$blog_id",
        "static=" . _encode_url( $q->param("static") ),
    );

    if ( my $entry_id = $q->param("entry_id") ) {
        $entry_id =~ s/\D//g;
        push @params, "entry_id=$entry_id";
    }

    my $return_url
        = $app->base
        . $app->path
        . $cfg->CommentScript . "?"
        . join( '&', @params );
    return _encode_url($return_url);
}

sub login {
    my $class = shift;
    my ($app) = @_;
    my $q     = $app->param;

    my $blog_id          = $app->blog->id;
    my $facebook_api_key = instance($app)
        ->get_config_value( 'facebook_app_key', "blog:$blog_id" );

    my $url = "https://www.facebook.com/dialog/oauth?"
        . join( '&',
        "client_id=" . $facebook_api_key,
        "redirect_uri=" . __create_return_url($app),
        );
    return $app->redirect($url);
}

sub handle_sign_in {
    my $class = shift;
    my ( $app, $auth_type ) = @_;
    my $q = $app->param;

    if ( $q->param("error") ) {
        return $app->error( "Authonticating end in error: "
                . $q->param("error")
                . ", reason:"
                . $q->param("error_description") );
    }

    my $success_code = $q->param("code");
    my $ua = $app->new_ua( { paranoid => 1 } );

    my $plugin  = instance($app);
    my $blog_id = $app->blog->id;
    my $facebook_api_key
        = $plugin->get_config_value( 'facebook_app_key', "blog:$blog_id" );
    my $facebook_api_secret
        = $plugin->get_config_value( 'facebook_app_secret', "blog:$blog_id" );

    my $return_url = __create_return_url($app);

    my @url_params = (
        "client_id=$facebook_api_key",        "redirect_uri=$return_url",
        "client_secret=$facebook_api_secret", "code=$success_code"
    );

    my $url = "https://graph.facebook.com/oauth/access_token?"
        . join( '&', @url_params );
    my $response = $ua->get($url);
    return $app->errtrans("Invalid request.")
        unless $response->is_success;

    my $content = $response->decoded_content();
    return $app->errtrans("Invalid request.")
        unless $content =~ m/^access_token=(.*)/m;

    my $access_token = $1;
    $access_token =~ s/\s//g;
    $access_token =~ s/&.*//;

    $url      = "https://graph.facebook.com/me?access_token=$access_token";
    $response = $ua->get($url);
    return $app->errtrans("Invalid request.")
        unless $response->is_success;

    require JSON;
    my $user_data = JSON::from_json( $response->decoded_content() );

    my $nickname = $user_data->{name};
    my $fb_id    = $user_data->{id};

    my $author_class = $app->model('author');
    my $cmntr        = $author_class->load(
        {   name      => $fb_id,
            type      => $author_class->COMMENTER(),
            auth_type => $auth_type,
        }
    );

    if ( not $cmntr ) {
        $cmntr = $app->make_commenter(
            name        => $fb_id,
            nickname    => $nickname,
            auth_type   => $auth_type,
            external_id => $fb_id,
            url         => "http://www.facebook.com/profile.php?id=$fb_id",
        );
    }

    return $app->error("Failed to created commenter")
        unless $cmntr;

    __get_userpic($cmntr);

    $app->make_commenter_session($cmntr)
        or return $app->error("Failed to create a session");

    return $cmntr;
}

sub __get_userpic {
    my ($cmntr) = @_;

    if ( my $userpic = $cmntr->userpic ) {
        require MT::FileMgr;
        my $fmgr     = MT::FileMgr->new('Local');
        my $mtime    = $fmgr->file_mod_time( $userpic->file_path() );
        my $INTERVAL = 60 * 60 * 24 * 7;
        if ( $mtime > time - $INTERVAL ) {

            # newer than 7 days ago, don't download the userpic
            return;
        }
    }

    require MT::Auth::OpenID;
    my $picture_url
        = "http://graph.facebook.com/"
        . $cmntr->external_id
        . "/picture?type=large";

    if ( my $userpic = MT::Auth::OpenID::_asset_from_url($picture_url) ) {
        $userpic->tags('@userpic');
        $userpic->created_by( $cmntr->id );
        $userpic->save;
        if ( my $userpic = $cmntr->userpic ) {

         # Remove the old userpic thumb so the new userpic's will be generated
         # in its place.
            my $thumb_file = $cmntr->userpic_file();
            my $fmgr       = MT::FileMgr->new('Local');
            if ( $fmgr->exists($thumb_file) ) {
                $fmgr->delete($thumb_file);
            }
            $userpic->remove;
        }
        $cmntr->userpic_asset_id( $userpic->id );
        $cmntr->save;
    }
}

sub __check_api_configuration {
    my ( $app, $plugin, $facebook_api_key, $facebook_api_secret ) = @_;

    return $plugin->error("Could not verify this app with Facebook")
        unless ( $facebook_api_key and $facebook_api_secret );

    my $url = "https://graph.facebook.com/oauth/access_token?";
    $url .= join( '&',
        "client_id=$facebook_api_key",
        "client_secret=$facebook_api_secret",
        "grant_type=client_credentials",
    );

    my $ua = $app->new_ua( { paranoid => 1 } );
    my $response = $ua->get($url);
    return $plugin->error("Could not verify this app with Facebook")
        unless $response->is_success;

    my $content = $response->decoded_content();
    return $plugin->error("Could not verify this app with Facebook")
        unless $content =~ m/^access_token=(.*)/m;

    return 1;
}

my $mt_support_save_config_filter;

sub plugin_data_pre_save {
    my ( $cb, $obj, $original ) = @_;

    return 1 if $mt_support_save_config_filter;

    my ( $args, $scope ) = ( $obj->data, $obj->key );

    return 1
        unless ( $obj->plugin eq $PluginKey )
        && ( $scope =~ m/^configuration/ );

    $scope =~ s/^configuration:?|:.*//g;
    return 1 unless $scope eq 'blog';

    my $facebook_api_key    = $args->{facebook_app_key};
    my $facebook_api_secret = $args->{facebook_app_secret};

    my $app    = MT->instance;
    my $plugin = instance($app);

    return __check_api_configuration( $app, $plugin, $facebook_api_key,
        $facebook_api_secret );
}

sub check_api_key_secret {
    my ( $cb, $plugin, $data ) = @_;

    $mt_support_save_config_filter = 1;

    my $app = MT->instance;

    my $facebook_api_key    = $data->{facebook_app_key};
    my $facebook_api_secret = $data->{facebook_app_secret};

    return __check_api_configuration( $app, $plugin, $facebook_api_key,
        $facebook_api_secret );
}

sub GreetFacebookCommenters {
    return '';
}

sub _encode_url {
    my ( $str, $enc ) = @_;
    $enc ||= MT->config->PublishCharset;
    my $encoded = Encode::encode( $enc, $str );
    $encoded =~ s!([^a-zA-Z0-9_.-])!uc sprintf "%%%02x", ord($1)!eg;
    $encoded;
}

1;
