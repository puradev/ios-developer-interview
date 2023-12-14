if which brew >/dev/null; then
  echo "Homebrew is installed"
else
  echo "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if which xcodes >/dev/null; then
  echo "Xcodes CLI is already installed"
else
  echo "Installing Xcodes CLI"
  brew install xcodesorg/made/xcodes
fi

# Fast and modern Ruby version manager written in Rust
# For managing fastlane - experimental Swift version exists,
# but isn't time tested.
brew install frum
# Automation tool written in Ruby
brew install fastlane
# For faster downloads in Xcodes
brew install aria2

if [[ $(xcodes installed) ]]; then
  echo "Xcode is installed, skipping..."
else
  echo "This next step will install Xcode, but requires an Apple ID and password."
  echo "This process may take a while. Install now? y/n"
  read selection
  case $selection in
    y) xcodes install 15.0 ;;
    n) : ;;
    *) echo "Invalid input. Reply with y or n."
  esac
fi

# For enforcing Swift conventions and breaking bad habits
brew install swiftlint