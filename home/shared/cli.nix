{ pkgs, ... }:
{
  # CLI tools on every machine. git comes from programs.git (git.nix).
  home.packages = with pkgs; [
    # core
    # Rust rewrite of coreutils, without the uu- prefix, so `ls`, `cp`, ...
    # resolve to it ahead of the BSD (macOS) or GNU (NixOS) versions.
    uutils-coreutils-noprefix
    curl
    fd
    htop
    jq
    pass
    pv
    rclone
    ripgrep
    tree
    zstd

    # network
    dig

    # media & docs
    exiftool
    ffmpeg
    hugo

    # cloud
    gh
    hcloud
    k9s
    kubectl
    kubernetes-helm

    # rust
    cargo
    cargo-watch
    clippy
    rustc
    rustfmt

    # python
    basedpyright
    ruff
    uv

    # javascript
    bun
    nodejs

    # go (GOPATH/GOBIN are set in bash.nix)
    go
    gotools

    # build & data
    just
    protobuf
    sqlite

    # ai
    claude-code
    codex
    herdr # agent multiplexer for the terminal
  ];
}
