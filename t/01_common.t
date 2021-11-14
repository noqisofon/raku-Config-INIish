# -*- mode: raku; -*-
use Test;

use lib './lib';
use Config::INIish;

plan 8;

my $hoge = Config::INIish.new(:filename('./my-config.conf'));

is './my-config.conf', $hoge.filename;

$hoge<build-config><builder>              = 'piyo.builder.Builder';
$hoge<build-config><tagger>               = 'piyo.tagger.VersionTagger';
$hoge<build-config><lib-dir>              = '.piyo/custom/';

$hoge<tag1><dist-tag>                     = 'el5';

$hoge<tag2><dist-tag>                     = 'el5';

$hoge<version-template><destination-file> = 'src/piyo/__init__.ry';
$hoge<version-template><template-file>    = 'src/templates/__init__.ry';

is 'piyo.builder.Builder'     , $hoge<build-config><builder>;
is 'piyo.tagger.VersionTagger', $hoge<build-config><tagger>;
is '.piyo/custom/'            , $hoge<build-config><lib-dir>;

is 'el5'                      , $hoge<tag1><dist-tag>;
is 'el5'                      , $hoge<tag2><dist-tag>;

is 'src/piyo/__init__.ry'     , $hoge<version-template><destination-file>;
is 'src/templates/__init__.ry', $hoge<version-template><template-file>;

done-testing;
