{ ... }:
{
  programs.ghostty = {
    enable = true;
    # We don't use bat; the module would otherwise wire up its syntax definition.
    installBatSyntax = false;

    settings = {
      # Built-in copies of the Terminal.app palettes, following light/dark mode.
      theme = "light:Terminal Basic,dark:Terminal Basic Dark";

      # Fallback chain: missing fonts are skipped. SF Mono is only installed on
      # macOS (see home/darwin/sf-mono.nix), so Linux ends up on Hasklig.
      font-family = [ "SF Mono" "Menlo" "Hasklig" ];
      font-size = 13;

      window-padding-x = 8;
      window-padding-y = 4;
      window-padding-balance = true;

      # Shell integration forces a bar cursor at the prompt; `no-cursor` keeps
      # the block. `no-title` stops the title switching to the running command;
      # the prompt sets the title to the working directory instead.
      cursor-style = "block";
      shell-integration-features = "no-cursor,no-sudo,no-title,no-ssh-env,no-ssh-terminfo,path";
    };
  };
}
