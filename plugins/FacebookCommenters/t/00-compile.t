use strict;
use warnings;

use lib 'lib', 'extlib', 'plugins/FacebookCommenters/lib';
use Test::More;

use_ok('FacebookCommenters::App');
use_ok('FacebookCommenters::Auth');

done_testing;

