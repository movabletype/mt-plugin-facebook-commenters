# Copyright (C) 2008 Six Apart, Ltd. All Rights Reserved.
#
# Licensed under the same terms as Perl itself.

package FacebookCommenters::L10N::ja;

use strict;
use utf8;
use base 'FacebookCommenters::L10N::en_us';
use vars qw( %Lexicon );
%Lexicon = (

## plugins/FacebookCommenters/config.yaml
	'Provides commenter registration through Facebook Connect.' => 'Facebookコネクトを利用したコメント投稿者の登録機能を提供します。',
	'Facebook' => 'Facebook',

## plugins/FacebookCommenters/lib/FacebookCommenters/Auth.pm
	'Set up Facebook Commenters plugin' => 'Facebook Commentersプラグイン設定',

## plugins/FacebookCommenters/tmpl/blog_config_template.tmpl
	'Facebook Application Key' => 'Facebookアプリケーションキー',
	'The key for the Facebook application associated with your blog.' => 'ブログ関連付用Facebookアプリケーションキー',
	'Edit Facebook App' => 'Facebookアプリ編集',
	'Create Facebook App' => 'Facebookアプリ作成',
	'Facebook Application Secret' => 'Facebookアプリケーションシークレット',
	'The secret for the Facebook application associated with your blog.' => 'ブログ関連付用Facebookアプリケーションシークレット',

);

1;
