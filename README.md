# .dotfiles
Current config on macOS: vscode, zsh, ohmyzsh with spaceship. Instructions for personal reference.

## VSCode
- Download and install [vscode](https://code.visualstudio.com/): `sudo dpkg -i <installfile>.deb; sudo apt-get install -f` on Debian-based distros, download and double-click on macOS;
- Copy .vscode-extensions and run `cat .vscode-extensions | xargs -L 1 code --install-extension` to install the extensions
- Either open vscode and edit the settings, or copy the settings.json file in /path/to/vscode/settings.json and edit if needed
- (optional) do the same for the keybindings

## zsh
- Install [zsh](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH). On deb `sudo apt-get install zsh` should do, on macOS `brew install zsh zsh-completions`
- Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), follow the instructions
- Install [spaceship](https://github.com/denysdovhan/spaceship-prompt), follow the instructions for oh-my-zsh
- Copy the .zshrc file in your home folder (or wherever zsh will be pointing at), and edit if needed
- (optional) make zsh the default shell `chsh -s $(which zsh)` (add `sudo` for root)
- restart terminal or `source ~/.zshrc`
