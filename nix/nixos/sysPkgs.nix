{ config, pkgs, ... }:

{
nixpkgs.config.allowUnfree = true;

# Set of packages that will appear in /run/current-system/sw :
environment.systemPackages = with pkgs; [

# Some softwares usefulls :
  firefox
  imagemagick    # display cmd for pictures
  evince         # pdf reader
  pavucontrol    # pulseaudio cmd for sound configuration
  cups           # print to pdf (= pdfcreator)

# Some tools for plasma5
  redshift
  redshift-plasma-applet

# Extra bash commands :
  tree
  htop
  wget
  gitAndTools.gitFull #gitk && git gui
  mkpasswd            # to encrypt password
  unzip
  nox                 # make easier to find nix packages
  shutter             # screen capture
  ctags # generates an tags file of names

# Standard Programming env
  gcc5
  clangStdenv
  clang
  cmakeCurses
  paraview
  gnuplot

# Personnal vim
  (vim_configurable.override {lua=lua; python=python;})
  (import ./vim-custom.nix)
  powerline-fonts
  xclip # to enable "*y to copy to the clipboard

# ssh :
  tigervnc

# Nix :
  nix-prefetch-scripts # to get SHA or MD5 for nixpkgs files
  pypi2nix

# Favorite Terminal :
  xfce.terminal
  #terminator
];

}
