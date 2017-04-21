# Movable Type (r) (C) 2001-2017 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

package FacebookCommenters::L10N::nl;

use strict;
use base 'FacebookCommenters::L10N::en_us';
use vars qw( %Lexicon );
%Lexicon = (

## plugins/FacebookCommenters/config.yaml
	'Provides commenter registration through Facebook Connect.' => 'Voegt registratie van reageerders toe via Facebook Connect.',
	'Facebook' => 'Facebook',

## plugins/FacebookCommenters/lib/FacebookCommenters/Auth.pm
	'Set up Facebook Commenters plugin' => 'Facebook Reageerders plugin instellen',
	'Authentication failure: [_1], reason:[_2]' => 'Authenticatie mislukt: [_1], reden: [_2]',
	'Failed to created commenter.' => 'Aanmaken reageerder mislukt.',
	'Failed to create a session.' => 'Aanmaken sessie mislukt.',
	'Facebook Commenters needs either Crypt::SSLeay or IO::Socket::SSL installed to communicate with Facebook.' => 'Facebook Commenters vereist dat ofwel Crypt::SSLeay of IO::Socket::SSL geïnstalleerd zijn om met Facebook te kunnen communiceren.', # Translate - New
	'Please enter your Facebook App key and secret.' => 'Gelieve uw Facebook App key en secret in te vullen.', # Translate - New
	'Could not verify this app with Facebook: [_1]' => 'Kon deze app niet verifiëren bij Facebook: [_1]', # Translate - New

## plugins/FacebookCommenters/tmpl/blog_config_template.tmpl
	'Facebook App ID' => 'Facebook applicatiesleutel',
	'The key for the Facebook application associated with your blog.' => 'De sleutel voor de Facebook-applicatie geassocieerd met uw blog.',
	'Edit Facebook App' => 'Facebook app bewerken',
	'Create Facebook App' => 'Facebook app aanmaken',
	'Facebook Application Secret' => 'Facebook applicatiegeheim',
	'The secret for the Facebook application associated with your blog.' => 'Het geheim voor de Facebook-applicatie geassocieerd met uw blog.',

);

1;
