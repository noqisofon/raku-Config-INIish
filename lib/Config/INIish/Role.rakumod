unit role Config::INIish::Role;

has %.store     is rw;
has $.filename  is rw;

multi method AT-KEY($key) {
    unless %.store{$key}:exists {
        %.store{$key} = Hash.new;
    }
    %.store{$key}
}

# multi method ASSIGN-KEY($key, $new) {
# }
