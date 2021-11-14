# -*- mode: raku; -*-
use Test;

use lib './lib';
use Config::INIish::Grammar;

my $contents = qq{
[build-config]
builder = piyo.builder.Builder
tagger  = piyo.tagger.VersionTagger
;
lib_dir = .piyo/custom/
};

my token eol {
    [ <[#;]> \N ]? \n
}

my regex key {
    <![#\[]> <-[;=\s]>+
}

my regex value {
    [ <![;=]> \N ]+
}

my token key-and-value {
    ^^
    \h* <key> \h* '=' \h* <value>? \h* <eol>*
}

my token top-level {
    <key-and-value>*
}

my token header-text {
    <-[\]]>*
}

my token header {
    ^^
    \h* '[' \h*  <header-text> \h* ']' \h* <eol>+
}

my token sections {
    <header> <key-and-value>
}

{
    ok so $contents ~~ &header;

    is 'build-config', $/<header-text>, '/<header-text> is "build-config"';
}

{
    ok so 'builder = piyo.builder.Builder' ~~ &key-and-value;

    is 'builder'             , $/<key>.Str    , '/<key> is "builder"';
    is 'piyo.builder.Builder', $/<value>.Str  , '/<value> is "piyo.builder.Builder"';
}

{
    ok so $contents ~~ &sections;

    note $/.keys;

    is 'build-config', $/<header><header-text>;
}

done-testing;
