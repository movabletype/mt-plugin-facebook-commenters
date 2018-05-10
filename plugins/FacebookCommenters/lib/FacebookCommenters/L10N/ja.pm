# Movable Type (r) (C) 2001-2017 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: $

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
	'Authentication failure: [_1], reason:[_2]' => '認証に失敗しました: [_1], 理由:[_2]',
	'Failed to created commenter.' => 'コメンターの作成に失敗しました。',
	'Failed to create a session.' => 'コメンターセッションの作成に失敗しました。',
	'Facebook Commenters needs either Crypt::SSLeay or IO::Socket::SSL installed to communicate with Facebook.' => 'Facebook Commenters を利用するには、Crypt::SSLeay または IO::Socket::SSLのいずれかがインストールされている必要があります。',
	'Please enter your Facebook App key and secret.' => 'FacebookアプリケーションキーとFacebookアプリケーションシークレットを入力してください。',
	'Could not verify this app with Facebook: [_1]' => 'Facebookでこのアプリケーションを確認できません: [_1]',

## plugins/FacebookCommenters/tmpl/blog_config_template.tmpl
	'OAuth Redirect URL of Facebook Login' => 'OAuth リダイレクトURL',
	'Please set this URL to "Valid OAuth redirect URIs" field of Facebook Login.' => 'このURLを "Valid OAuth redirect URIs" に設定してください。',
	'Facebook App ID' => 'Facebookアプリケーションキー',
	'The key for the Facebook application associated with your blog.' => 'ブログ関連付用Facebookアプリケーションキー',
	'Edit Facebook App' => 'Facebookアプリ編集',
	'Create Facebook App' => 'Facebookアプリ作成',
	'Facebook Application Secret' => 'Facebookアプリケーションシークレット',
	'The secret for the Facebook application associated with your blog.' => 'ブログ関連付用Facebookアプリケーションシークレット',

);

1;
