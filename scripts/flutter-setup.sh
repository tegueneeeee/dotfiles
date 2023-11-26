#!/bin/bash

if xcodebuild -version >/dev/null; then
	echo "Xcode is already installed ✅ "
else
	echo "Installing Xcode..."
	xcodes install --latest --select
	echo "Completed install Xcode ✅ "
fi
