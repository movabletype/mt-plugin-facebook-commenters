# Copyright (C) 2008 Six Apart, Ltd. All Rights Reserved.
#
# Licensed under the same terms as Perl itself.

package FacebookCommenters::L10N::fr;

use strict;
use base 'FacebookCommenters::L10N::en_us';
use vars qw( %Lexicon );
%Lexicon = (
## plugins/FacebookCommenters/config.yaml
	q{Provides commenter registration through Facebook Connect.} => q{Permet l'enregistrement des auteurs de commentaires via Facebook Connect},
	'Facebook' => 'Facebook',

## plugins/FacebookCommenters/lib/FacebookCommenters/Auth.pm
	'Set up Facebook Commenters plugin' => 'Configurer le plugin Facebook Commenters',
	'Authentication failure: [_1], reason:[_2]' => 'Échec de l\'authentification : [_1], raison : [_2]',
	'Failed to created commenter.' => 'Impossible de créer le commentateur.',
	'Failed to create a session.' => 'Impossible de créer une session.',
	'Facebook Commenters needs either Crypt::SSLeay or IO::Socket::SSL installed to communicate with Facebook.' => 'Facebook Commenters nécessite l\'installation de Crypt::SSLeay ou de IO::Socket::SSL pour communiquer avec Facebook.', # Translate - New
	'Please enter your Facebook App key and secret.' => 'Veuillez entrer votre clé et code secret d\'application Facebook.', # Translate - New
	'Could not verify this app with Facebook: [_1]' => 'impossible de vérifier cette application avec Facebook : [_1]', # Translate - New

## plugins/FacebookCommenters/tmpl/blog_config_template.tmpl
	'Facebook Application Key' => 'Clé Application Facebook',
	q{The key for the Facebook application associated with your blog.} => q{La clé pour l'application Facebook associée à votre blog.},
	q{Edit Facebook App} => q{Éditer l'application Facebook},
	'Create Facebook App' => 'Créer une application Facebook',
	'Facebook Application Secret' => 'Secret Application Facebook',
	q{The secret for the Facebook application associated with your blog.} => q{Le secret pour l'application Facebook associée à votre blog.},


);

1;
