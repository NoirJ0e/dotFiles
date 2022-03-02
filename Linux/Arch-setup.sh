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
paru -S rsync ueberzug flameshot fcitx5 fcitx5-rime fcitx5-qt fcitx5-gtk yakuake trash-cli brave-bin obsidian xournalpp texlive-most

rsync -a nvim/ $HOME/.config/nvim
rsync -a ranger/ $HOME/.config/ranger
