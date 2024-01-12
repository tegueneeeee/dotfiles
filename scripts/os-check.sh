#!/bin/bash

mac_requirement() {
	if xcrun --version >/dev/null; then
		echo "CommandLineTools is already installed"
	else
		echo "Installing CommandLineTools..."
		xcode-select --install
		echo "Completed installing CommandLineTools ✅ "
	fi
	if [[ $(uname -m) == "arm64" ]]; then
		echo "Softwareupdate rosetta, licence..."
		sudo softwareupdate --install-rosetta --agree-to-license
		echo "Completed Softwareupdate ✅"
	fi
	if type brew >/dev/null; then
		echo "Brew already installed"
	else
		echo "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
		echo "Completed installing Homebrew ✅ "
	fi
	brew update
	brew upgrade --cask --greedy
	brew bundle
	
	echo "Installing zap"
	zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
	echo "Completed installing zap"
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# linux
	echo OS: linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
	echo OS: macosx
	mac_requirement
elif [[ "$OSTYPE" == "freebsd"* ]]; then
	echo OS: freebsd
else
	echo OS: others
fi
