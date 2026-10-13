{ pkgs, username, homeDirectory, ... }:

{
  imports = [
    ./tmux.nix
    ./zsh.nix
  ];

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
    yazi
    helix
    distroshelf
    gh
  ];
  services.podman.enable = true;
  programs.distrobox.enable = true;
  programs.ghostty =  {
    enable = true;
    settings = {
      gtk-titlebar = false;
      window-decoration = false;
    };
  };
  programs.git = {
    enable = true;

    settings.user.name = "Roger Padrell";
    settings.user.email = "padrell.roger@gmail.com";
  };
}
