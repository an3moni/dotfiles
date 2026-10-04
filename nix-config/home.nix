{ pkgs, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    git
    zsh
    ripgrep
    fd
    jq
    tree
    htop
    helix
  ];

  programs.git = {
    enable = true;

    settings.user.name = "Roger Padrell";
    settings.user.email = "padrell.roger@gmail.com";
  };

  programs.zsh.enable = true;

  home.sessionVariables = {
    EDITOR = "hx";
  };
}


