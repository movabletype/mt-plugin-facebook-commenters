package FacebookCommenters::App;
use strict;
use warnings;

use MT;

sub blog_config_tmpl {
    my ( $plugin, $param, $scope ) = @_;
    $plugin->load_tmpl( 'blog_config_template.tmpl',
        { 'fb_app_redirect_url' => _redirect_url() } );
}

sub _redirect_url {
    my $app = MT->instance;
    $app->app_path
        . $app->config->CommentScript
        . $app->uri_params(
        mode => 'handle_sign_in',
        args => { key => 'Facebook' },
        );
}

1;

