# .dotfiles

## Installation

1. Install the following

   - zsh
   - nvim
   - tmux
   - xclip
   - git
   - fzf
   - [tmuxifier](https://github.com/jimeh/tmuxifier)
   - stow
   - A [nerd font](https://www.nerdfonts.com/) or use one in the fonts folder
     - Set this font for your terminal
   - [nvm](https://github.com/nvm-sh/nvm)
     - have the latest node version installed

   ```sh
   nvm install --lts
   nvm use --lts
   ```

   - Install yarn

   ```sh
   npm install -g yarn
   ```

2. Clone in your home directory
3. Run the ubuntu.sh script
4. Restart to get zsh to be your default shell
5. Install [oh my zsh](https://ohmyz.sh/)
6. Install [powerlevel10k](https://github.com/romkatv/powerlevel10k)
7. Install [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

   I needed to do this for mac

   ```sh
   git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
   ```

8. Install [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

   I needed to do this for mac

   ```sh
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
   ```

9. Follow [.netrc config](https://github.com/tpope/vim-rhubarb) instructions to
   use GBrowse through fugitive.
10. (Optional) add .gitconfig-work for git work email

### Mac

After installation

```sh
brew install --cask git-credential-manager
```

Make sure that you go to Profiles -> Keys -> General and make "Left Option Key" to act as "ESC+" so left alt works

## Where to put Repos

- ~/work
- ~/oss

## Mac OS

### [Brew](https://docs.brew.sh/Installation)

After installation

```sh
xargs brew install < my_brew.txt
```

### Save Brew List

```sh
brew leaves > my_brew.txt
```

## Sign Git Commit

[Create a GPG key](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)

Update `~/.extend.gitconfig-oss` with the signing key value

```gitconfig
[user]
    signingkey = XXXXXXXXXXXXXXXX

```
