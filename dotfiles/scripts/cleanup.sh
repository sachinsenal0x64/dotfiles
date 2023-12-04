pacman -Scc
paru -Scc
paccache --remove
su -c 'pacman -Qtdq | pacman -Rns -'
su -c 'pacman -Qqd  | pacman -Rsu  -'
su -c 'paru   -Qqd  | paru   -Rsu  -'
