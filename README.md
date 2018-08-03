# .dotfiles
Current config on macOS: vscode, zsh, ohmyzsh with spaceship. Instructions for personal reference.

## VSCode
- Install font [Fira Code](https://github.com/tonsky/FiraCode) (needed both for zsh and vscode)
- Download and install [vscode](https://code.visualstudio.com/): `sudo dpkg -i <installfile>.deb; sudo apt-get install -f` on Debian-based distros, download and double-click on macOS;
- Copy .vscode-extensions and run `cat .vscode-extensions | xargs -L 1 code --install-extension` to install the extensions
- Either open vscode and edit the settings, copy the settings.json file in /path/to/vscode/settings.json, or symlink /path/to/vscode/settings.json to the file in the repo. Edit if needed.

## zsh
- Install [zsh](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH). On deb `sudo apt-get install zsh` should do, on macOS `brew install zsh zsh-completions`
- Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), follow the instructions
- Install [spaceship](https://github.com/denysdovhan/spaceship-prompt), follow the instructions for oh-my-zsh
- Install [zsh-completions](https://github.com/zsh-users/zsh-completions), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), always follow instructions for oh-my-zsh
- change terminal emulator font to Fira Code (or anything you like with powerlines, and ligatures if you want to)
- Copy/symlink the .zshrc file in your home folder (or wherever zsh will be pointing at), and edit if needed
- Copy/symlink the .zsh_aliases file in your home folder (or wherever zsh will be pointing at), and edit if needed
- (optional) make zsh the default shell `chsh -s $(which zsh)` (add `sudo` for root)
- restart terminal or `source ~/.zshrc`

## Screenshots
![zsh screenshot](imgs/zsh.png?raw=true "zsh")
![vscode screenshot](imgs/vscode.png?raw=true "code")
