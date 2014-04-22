# Facebook Commenters Plugin for Movable Type

* Authors: Mark Paschal and David Recordon
* Copyright (C) 2008-2013 Six Apart Ltd.
* License: MIT


## Overview

The Facebook Commenters plugin for Movable Type allows commenters to login
and comment to your blog using their Facebook account. Upon login, a user
will be created localy for this Facebook user, with their name and public
profile picture. (if one exists)

## Prerequisites

* Movable Type 5.1 or higher
* Movable Type 4.3 or higher
** On Movable Type 4.3x, Need upgrade HTTP::Message module latest. http://search.cpan.org/~gaas/HTTP-Message/
* JSON (bundled with MT)

## Installation

1. Unpack the FacebookCommenters archive.
3. Copy the contents of FacebookCommenters/mt-static into /path/to/mt/mt-static/
4. Copy the contents of FacebookCommenters/plugins into /path/to/mt/plugins/
5. Login to your Movable Type Dashboard which will install the plugin.
6. Navigate to the Plugin Settings on the blog you wish to allow Facebook commenters.
7. Click on 'Create Facebook App' link, and create your app on Facebook
    1. Keep all of the defaults, except enter a Callback URL. This URL should point to the top-level directory of the site which will be implementing Facebook Connect (this is usually your domain, e.g. http://www.example.com, but could also be a subdirectory).
    2. Take note of the API Key and Secret as you'll need these shortly.

8. Within your blog's Plugin Settings, input the API Key and Secret from Facebook.
9. Edit your templates to include Facebook Connect tags and customize the display.
10. Enable "Facebook" as a Registration Authentication Method via Preferences -> Registration and ensure that User Registration is allowed.
11. Republish your blog for all of the changes to take effect.

## Template Code

### Using the GreetFacebookCommenters Slug

For backward compatibility, please add this tag to your HTML `<head>` of your web site

    <$mt:GreetFacebookCommenters$>

### Displaying Facebook Profile Userpics

To display a Facebook user's profile photo next to their comment, you will have to use a Comment Detail template which includes userpics.  The following template should work in most cases and http://www.movabletype.org/documentation/designer/publishing-comments-with-userpics.html is a useful guide to adding userpics to your templates.

    <div class="comment"<mt:IfArchiveTypeEnabled archive_type="Individual"> id="comment-<$mt:CommentID$>"</mt:IfArchiveTypeEnabled>>
        <div class="inner">
            <div class="comment-header">
                <div class="user-pic<mt:If tag="CommenterAuthType" eq="Facebook"> comment-fb-<$mt:CommenterUsername$></mt:If>">

                <mt:If tag="CommenterAuthType" eq="Facebook">
                    <a href="http://www.facebook.com/profile.php?id=<$mt:CommenterUsername$>" class="auth-icon"><img src="<$mt:CommenterAuthIconURL size="logo_small"$>" alt="<$mt:CommenterAuthType$>"/></a>
                    <fb:profile-pic uid="<$mt:CommenterUsername$>" size="square" linked="true"><img src="http://static.ak.connect.facebook.com/pics/q_default.gif" /></fb:profile-pic>

                <mt:Else>
                    <mt:If tag="CommenterAuthIconURL">
                        <a href="<$mt:CommenterURL$>" class="auth-icon"><img src="<$mt:CommenterAuthIconURL size="logo_small"$>" alt="<$mt:CommenterAuthType$>"/></a>
                    </mt:If>
                    <img src="<$mt:StaticWebPath$>images/default-userpic-50.jpg" />
                </mt:If>
                </div>

                <div class="asset-meta">
                    <span class="byline">
                    <mt:If tag="CommenterAuthType" eq="Facebook">
                        By <span class="vcard author"><fb:name uid="<$mt:CommenterUsername$>" linked="true" useyou="false"><a href="http://www.facebook.com/profile.php?id=<$mt:CommenterUsername$>"><$mt:CommenterName$></a></fb:name></span> on <a href="#comment-<$mt:CommentID$>"><abbr class="published" title="<$mt:CommentDate format_name="iso8601"$>"><$mt:CommentDate$></abbr></a></span>

                    <mt:Else>
                        By <span class="vcard author"><mt:If tag="CommenterURL"><a href="<$mt:CommenterURL$>"><$mt:CommentAuthor default_name="Anonymous" $></a><mt:Else><$mt:CommentAuthorLink default_name="Anonymous" show_email="0"$></mt:If></span><mt:IfNonEmpty tag="CommentAuthorIdentity"><$mt:CommentAuthorIdentity$></mt:IfNonEmpty> on <a href="#comment-<$mt:CommentID$>"><abbr class="published" title="<$mt:CommentDate format_name="iso8601"$>"><$mt:CommentDate$></abbr></a></span>
                    </mt:If>
                    </span>
                </div>
            </div>
            <div class="comment-content">
                <$mt:CommentBody$>
            </div>
        </div>
    </div>

The plugin's root directory also has an example file
`comment_detail.mtml.example`, which is the default Comment Detail template
module of the Community Blog template set included in MT 4.23 that also has the
functionality to add Facebook userpics described above.  If you are using the
default template module without any changes, you can overwrite
`/path/to/mt/addons/Community.pack/templates/blog/comment_detail.mtml` with
this file, and refresh the template from the Template Listing screen.
