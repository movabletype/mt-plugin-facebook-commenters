# Copyright (C) 2008 Six Apart, Ltd. All Rights Reserved.
#
# Licensed under the same terms as Perl itself.

package FacebookCommenters::L10N::de;

use strict;
use base 'FacebookCommenters::L10N::en_us';
use vars qw( %Lexicon );
%Lexicon = (

## plugins/FacebookCommenters/config.yaml
	'Provides commenter registration through Facebook Connect.' => 'Ermöglicht es Kommentarautoren, sich über Facebook Connect zu registrieren',
	'Facebook' => 'Facebook',

## plugins/FacebookCommenters/lib/FacebookCommenters/Auth.pm
	'Set up Facebook Commenters plugin' => 'Facebook Kommentarautoren-Plugin einrichten',
	'Authentication failure: [_1], reason:[_2]' => 'Authentifizierung fehlgeschlagen: [_1]. Grund: [_2]',
	'Failed to created commenter.' => 'Konnte Kommentarautoren nicht anlegen.',
	'Failed to create a session.' => 'Konnte Session nicht anlegen.',
	'Facebook Commenters needs either Crypt::SSLeay or IO::Socket::SSL installed to communicate with Facebook.' => 'Zur Verwendung des Facebook-Kommentarautoren-Plugins muss eines der Perl-Module Crypt::SSLeay oder IO::Socket::SSL installiert sein.', # Translate - New # OK
	'Please enter your Facebook App key and secret.' => 'Geben Sie Ihren Facebook-App-Key und den zugehörigen Code ein.', # Translate - New # OK
	'Could not verify this app with Facebook: [_1]' => 'Die App konnte nicht mit Facebook verknüpft werden:  [_1]', # Translate - New # OK

## plugins/FacebookCommenters/tmpl/blog_config_template.tmpl
	'Facebook Application Key' => 'Facebook Application Key',
	'The key for the Facebook application associated with your blog.' => 'Der Application Key der mit Ihrem Blog verknüpften Facebook-Anwendung',
	'Edit Facebook App' => 'Facebook-Anwendung bearbeiten',
	'Create Facebook App' => 'Facebook-Anwendung erstellen',
	'Facebook Application Secret' => 'Facebook Application Secret',
	'The secret for the Facebook application associated with your blog.' => 'Das Application Secret der mit Ihrem Blog verknüpften Facebook-Anwendung',

);

1;
