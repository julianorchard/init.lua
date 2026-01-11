" Signs
let gcfg = 'git config '
iab @@ hello@julianorchard.co.uk
iab <expr> ~g substitute(system(gcfg . 'user.name') . ' <' . system(gcfg . 'user.email') . '>', '\n', '', 'g')
