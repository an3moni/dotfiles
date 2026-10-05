{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    antidote = {
      enable = true;
      plugins = ["aloxaf/fzf-tab"];
    };
    
    # Use Zsh's normal completion system.
    enableCompletion = true;

    initContent = ''
      # ------------------------------------------------------------
      # OH MY POSH
      # ------------------------------------------------------------

      eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config ''${HOME}/.config/oh-my-posh/zen.toml)"


      # ------------------------------------------------------------
      # zoxide
      # ------------------------------------------------------------

      eval "$(${pkgs.zoxide}/bin/zoxide init zsh --cmd cd)"


      # ------------------------------------------------------------
      # History
      # ------------------------------------------------------------

      HISTSIZE=5000
      HISTFILE=~/.zsh_history
      SAVEHIST=$HISTSIZE
      HISTDUP=erase

      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt hist_save_no_dups
      setopt hist_ignore_dups
      setopt hist_find_no_dups


      # ------------------------------------------------------------
      # Keybindin      # ------------------------------------------------------------

      bindkey 'UPAR' history-search-backward
      bindkey 'DOWNAR' history-search-forward


      # ------------------------------------------------------------
      # Aliases
      # ------------------------------------------------------------

      alias ls='ls --color'


      # ------------------------------------------------------------
      # fzf
      # ------------------------------------------------------------

      eval "$(${pkgs.fzf}/bin/fzf --zsh)"


      # ------------------------------------------------------------
      # tmux
      # ------------------------------------------------------------

      if [[ -z "$TMUX" && -o interactive ]]; then
          exec tmux new -A -s main
      fi
    '';

    history = {
      size = 5000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };
  };

  home.packages = with pkgs; [
    zsh
    oh-my-posh
    zoxide
    fzf
    tmux
  ];
}
