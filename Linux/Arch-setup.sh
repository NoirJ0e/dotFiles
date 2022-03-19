# Setup the archlinuxcn mirror
echo "Server = https://mirror.sjtu.edu.cn/archlinux/\$repo/os/\$arch" >> /etc/pacman.d/mirrorlist
pacman -Sy --noconfirm
pacman -S archlinuxcn-keyring --noconfirm
pacman -S paru --noconfirm
# For nvim
mkdir -p $HOME/.config/nvim
# For ranger
mkdir -p $HOME/.config/ranger
# Make sure has rsync
paru -S rsync zoxide exa trash-cli nodejs npm yarn ueberzug the_silver_searcher texlive-most \
        flameshot fcitx5 fcitx5-rime fcitx5-qt fcitx5-gtk konsole yakuake brave-bin obsidian xournalpp \
        neovim iptables nftables fzf 

rsync -a nvim/ $HOME/.config/nvim
rsync -a ranger/ $HOME/.config/ranger
