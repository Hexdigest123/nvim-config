#!/bin/bash

package=("brew" "apt" "dpkg" "pacman")
package_to_use=null

for i in "${package[@]}"; do
  if command -v "$i" &> /dev/null; then
    echo "Found ${i}. Continue installation via ${i}"
    package_to_use=$i
    break
  fi
done

echo "All required packages are installed"
if [ "$(which git)" = "git not found" ]; then
  echo "Starting to install git"
  exec "$package_to_use install git"
  echo "Git was installed. Continue with nvim"
fi

echo "Cloning requirements for nvim config..."
exec "git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim"
echo "Cloned required packer.nvim"
echo "Installing Node.JS"
exec "$package_to_use install node"
echo "Installed Node.JS"

echo "Now please open packer.lua in ./lua/hexdigest/packer.lua in neovim. Run :so and :PackerSync"
echo "To install Tabnine please follow the instructions on their github: https://github.com/codota/tabnine-nvim"
