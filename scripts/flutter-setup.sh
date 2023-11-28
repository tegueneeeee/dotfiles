#!/bin/bash

if xcodebuild -version >/dev/null; then
	echo "Xcode is already installed ✅ "
else
	echo "Installing Xcode..."
	xcodes install --latest --select
	echo "Completed install Xcode ✅ "
	echo "Setting simctl path..."
	sudo xcode-select -s /Applications/Xcode.app/
	echo "Completed setup simctl path"
fi
