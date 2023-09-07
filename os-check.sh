#!/bin/bash
mac_requirement() {
  xcode-select --install
  if ! (type brew > /dev/null 2>&1); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo brew already installed
    brew bundle
  fi
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
