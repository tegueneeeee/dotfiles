# dotfiles

## Requirement

### Brew Install
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install git, gh
```sh
brew install git
brew install gh
brew install gpg
```

### Github auth
```sh
gh auth login -h github.com -s admin:gpg_key -p https -w
```

### gpg key
```sh
gpg --quick-gen-key Taekwon Kim <kimxordnjs@naver.com> $(hostname)' default default 0
```

```sh
./install
```

### yabai, skhd start
```sh
yabai --start-service
skhd --start-service
```
