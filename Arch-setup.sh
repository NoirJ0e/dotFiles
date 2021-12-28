# For nvim
mkdir -p $HOME/.config/nvim
# For ranger
mkdir -p $HOME/.config/ranger
# For BSPWM
mkdir -p $HOME/.config/bspwm
# For kitty
mkdir -p $HOME/.config/kitty

# Make sure has rsync
sudo pacman -S rsync ueberzug

rsync -a nvim/ $HOME/.config/nvim
rsync -a kitty/ $HOME/.config/kitty
rsync -a ranger/ $HOME/.config/kitty
cp zsh/.zshrc-linux $HOME/.zshrc
