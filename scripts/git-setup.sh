#!/bin/bash

mkdir -p "$HOME/.gnupg" && chmod 700 "$HOME/.gnupg"
echo "pinentry-program $(which pinentry-mac)" >"$HOME/.gnupg/gpg-agent.conf"
gpgconf --kill gpg-agent

function generate_key() {
	local CONFIG_NAME=$1
	local USER_NAME=$2
	local EMAIL=$3
	local AUTHOR="$USER_NAME <$EMAIL>"

	if gpg --list-secret-keys | grep -q "$AUTHOR" &>/dev/null; then
		echo "Key already exists ✅ : $AUTHOR"
		return
	fi

	if [[ "$GITHUB_ACTIONS" == 'true' ]]; then
		gpg --no-tty --pinentry-mode loopback --passphrase passwd --quick-gen-key "$AUTHOR" default default 0
	else
		gpg --quick-gen-key "$AUTHOR" default default 0
	fi

	GPG_KEY_ID=$(gpg --list-secret-keys --with-colons | awk -F: '$1 == "sec" {print $5}' | tail -n 1)
	GPG_PUBLIC_KEY=$(gpg --armor --export "$GPG_KEY_ID")

	if [[ "$GITHUB_ACTIONS" != 'true' ]]; then
		yes | gh auth login -h github.com -s admin:gpg_key -p https -w
		gh api \
			--method POST \
			-H "Accept: application/vnd.github+json" \
			/user/gpg_keys \
			-f name="$AUTHOR's GPG Key" \
			-f armored_public_key="$GPG_PUBLIC_KEY"
	fi

	cat <<EOT >>.gitconfig-"$CONFIG_NAME"
[user]
    name = "$USER_NAME"
    EMAIL = "$EMAIL"
    signingkey = "$GPG_KEY_ID"

EOT
}
CONFIG_NAME_PRIVATE="private"

USER_NAME="Taekwon Kim (tegueneeeee)"
EMAIL_PRIVATE="kimxordnjs@naver.com"

generate_key "$CONFIG_NAME_PRIVATE" "$USER_NAME" "$EMAIL_PRIVATE"

git config --global init.defaultBranch main
git config --global user.name "$USER_NAME"
git config --global user.email "$EMAIL_PRIVATE"
git config --global commit.gpgsign true
git config --global gpg.program "$(which gpg)"
git config --global includeIf."gitdir:~/Repos/$CONFIG_NAME_PRIVATE/".path ".gitconfig-$CONFIG_NAME_PRIVATE"
