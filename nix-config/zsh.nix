{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # Home Manager manages these plugins directly.
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-completions";
        src = "${pkgs.zsh-completions}/share/zsh-completions";
      }

    ];

    initContent = ''
      # Oh My Posh
      eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/zen.toml")"

      # zoxide
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh --cmd cd)"

      # History
      HISTSIZE=5000
      HISTFILE="$HOME/.zsh_history"
      SAVEHIST=$HISTSIZE
      HISTDUP=erase
      
      setopt APPEND_HISTORY
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_SPACE
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_IGNORE_DUPS
      setopt HIST_FIND_NO_DUPS

      # Keybindings
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      # Completion
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color "$realpath"'

      # Aliases
      alias ls='ls --color'

      # fzf integration
      eval "$(${pkgs.fzf}/bin/fzf --zsh)"

      # Start or attach to the main tmux session for interactive shells
      if [[ -z "$TMUX" && -o interactive ]]; then
        exec ${pkgs.tmux}/bin/tmux new -A -s main
      fi
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = false;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = false;
  };

  home.packages = with pkgs; [
    zsh
    oh-my-posh
    fzf
    zoxide
    git
  ];

  # Install the Oh My Posh theme.
  home.file.".config/oh-my-posh/zen.toml".source = ./zen.toml;
}


