# -*- mode: raku; -*-
use Test;

use lib './lib';

plan 2;

use-ok 'Config::INIish';
use-ok 'Config::INIish::Grammar';

done-testing;
