{ ... }:
{
  programs.bash.shellAliases = {
    nix-upgrade = "nix flake update --flake ~/personal/dotfiles && sudo darwin-rebuild switch --flake ~/personal/dotfiles#macbook";
  };

  # Build images for the x86 servers rather than Apple Silicon.
  home.sessionVariables.DOCKER_DEFAULT_PLATFORM = "linux/amd64";
}
