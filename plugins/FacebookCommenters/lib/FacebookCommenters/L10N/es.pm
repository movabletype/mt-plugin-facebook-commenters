# Movable Type (r) (C) 2001-2017 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id$

package FacebookCommenters::L10N::es;

use strict;
use base 'FacebookCommenters::L10N::en_us';
use vars qw( %Lexicon );
%Lexicon = (
## plugins/FacebookCommenters/config.yaml
	'Provides commenter registration through Facebook Connect.' => 'Provee registro de comentaristas a través de Facebook Connect.',
	'Facebook' => 'Facebook',

## plugins/FacebookCommenters/lib/FacebookCommenters/Auth.pm
	'Set up Facebook Commenters plugin' => 'Configurar la extesión de comentaristas de Facebook',
	'Authentication failure: [_1], reason:[_2]' => 'Fallo de autentificación: [_1], razón: [_2]',
	'Failed to created commenter.' => 'Falló al crear comentarista.',
	'Failed to create a session.' => 'Falló al crear una sesión.',
	'Facebook Commenters needs either Crypt::SSLeay or IO::Socket::SSL installed to communicate with Facebook.' => 'Los comentaristas de Facebook necesitan que Crypt::SSLeay o IO::Socket::SSL estén instalados para la comunicación con Facebook.', # Translate - New
	'Please enter your Facebook App key and secret.' => 'Por favor, introduzca el identificador y código secreto de app de Facebook.', # Translate - New
	'Could not verify this app with Facebook: [_1]' => 'No se pudo verificar esta aplicación en Facebook: [_1]', # Translate - New

## plugins/FacebookCommenters/tmpl/blog_config_template.tmpl
	'Facebook App ID' => 'Clave de la aplicación de Facebook',
	'The key for the Facebook application associated with your blog.' => 'La clave de la aplicación de Facebook asociada con su blog.',
	'Edit Facebook App' => 'Editar aplicación de Facebook',
	'Create Facebook App' => 'Crear aplicación de Facebook',
	'Facebook Application Secret' => 'Secreto de la aplicación de Facebook',
	'The secret for the Facebook application associated with your blog.' => 'El secreto de la aplicación de Facebook asociada con su blog.',
);

1;
