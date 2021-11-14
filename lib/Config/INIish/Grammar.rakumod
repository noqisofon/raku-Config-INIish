unit grammar Config::INIish::Grammar;

token TOP {
    ^
    <.eol>*
    <top-level>?
    <sections>*
    <.eol>*
    $
}

token top-level {
    <key-and-value>*
}

token sections {
    <header> <key-and-value>
}

token header-text {
    <-[\]]>*
}

token header {
    ^^
    \h* '[' \h*  <header-text> \h* ']' \h* <.eol>+
}

token key-and-value {
    ^^
    <key> '=' <value> <.eol>+
}

token key {
    <-[#\[]> <-[;=]>+
}

token value {
    [ <-[;=]> \N ]+
}

token eol {
    [ <[#;]> \N ]? \n
}
