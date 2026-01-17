# My Dotfiles

These are my personal dotfiles, managed by [chezmoi](https://www.chezmoi.io/).

## 1. Initial Setup (on a new macOS)

These steps will set up your machine from a clean state.

1.  **Install Homebrew:**
    Open a terminal and run the following command:
    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2.  **Install and Initialize `chezmoi`:**
    This command installs `chezmoi`, clones this dotfiles repository, and applies the configurations. This includes installing all other tools listed in the `Brewfile`, **and automatically applying essential macOS developer settings and your wallpaper.**

    *Replace `YOUR_GITHUB_USERNAME` with your actual username.*
    ```sh
    brew install chezmoi
    chezmoi init --apply https://github.com/YOUR_GITHUB_USERNAME/dotfiles.git
    ```

## 2. Profile Management

This setup uses a profile system to manage different configurations for `personal` (default) and `work` environments. Currently, this primarily affects which packages are installed via the `Brewfile`.

*   **To apply the `personal` configuration:**
    (This is the default if no profile is specified)
    ```sh
    chezmoi apply
    ```

*   **To apply the `work` configuration:**
    ```sh
    chezmoi apply --data '{"profile": "work"}'
    ```

After switching profiles, run `brew bundle install` to synchronize your packages.
```sh
brew bundle install
```

The profile logic is defined in `.chezmoi.toml.tmpl` and the `Brewfile` template is `dot_Brewfile.tmpl`.

## 3. Manual Post-Installation Steps

Some configurations require manual intervention after the initial setup.

1.  **Change Default Shell to Fish:**
    You may need to add Fish to the list of approved shells before changing it.
    ```sh
    echo $(which fish) | sudo tee -a /etc/shells
    chsh -s $(which fish)
    ```
    You will need to log out and log back in for the shell change to take effect.

2.  **Authenticate with GitHub CLI:**
    This is required for the `gh` command-line tool.
    ```sh
    gh auth login
    ```

3.  **Configure GPG Key for Git Signing:**
    If you wish to sign your commits, generate a GPG key and add it to your GitHub account.
    ```sh
    gpg --full-generate-key
    # Then follow GitHub's documentation to add the GPG key to your account.
    ```
