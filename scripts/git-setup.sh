#!/bin/bash

mkdir -p "$HOME/.gnupg" && chmod 700 "$HOME/.gnupg"
echo "pinentry-program $(which pinentry-mac)" >"$HOME/.gnupg/gpg-agent.conf"
gpgconf --kill gpg-agent

function generate_key() {
	local CONFIG_NAME=$1
	local USER_NAME=$2
	local EMAIL=$3
	local HOST_NAME=$4
	local AUTHOR="$USER_NAME <$EMAIL> $HOST_NAME"

	if gpg --list-secret-keys | grep -q "$AUTHOR" &>/dev/null; then
		echo "Key already exists ✅ : $AUTHOR"
	else
		echo "Key is not exist ⛔️ : $AUTHOR"
		echo "Try this command and restart ./install"
		echo "gpg --quick-gen-key '$(git config user.name) <$(git config user.email)> $(hostname)' default default 0"
		return
	fi

	GPG_KEY_ID=$(gpg --list-secret-keys --with-colons | awk -F: '$1 == "sec" {print $5}' | tail -n 1)
	GPG_PUBLIC_KEY=$(gpg --armor --export "$GPG_KEY_ID")
	git config --global user.signingkey "$GPG_KEY_ID"

	echo "Github POST GPG KEY"
	gh api \
		--method POST \
		-H "Accept: application/vnd.github+json" \
		/user/gpg_keys \
		-f name="$AUTHOR's GPG Key" \
		-f armored_public_key="$GPG_PUBLIC_KEY"
}
CONFIG_NAME_PRIVATE="private"

USER_NAME="Taekwon Kim (tegueneeeee)"
EMAIL_PRIVATE="kimxordnjs@naver.com"
HOST_NAME="$(hostname)"

generate_key "$CONFIG_NAME_PRIVATE" "$USER_NAME" "$EMAIL_PRIVATE" "$HOST_NAME"

git config --global init.defaultBranch main
git config --global user.name "$USER_NAME"
git config --global user.email "$EMAIL_PRIVATE"
git config --global commit.gpgsign true
git config --global gpg.program "$(which gpg)"
git config --global includeIf."gitdir:~/Repos/$CONFIG_NAME_PRIVATE/".path ".gitconfig-$CONFIG_NAME_PRIVATE"
