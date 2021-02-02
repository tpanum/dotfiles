{ stdenv, lib, linkFarm, fetchgit, fetchFromGitHub }:

{ crystal,
  gitShardsFile ? null,
  lockFile ? null,
  shardsFile ? null, ...}@args:

let
    buildArgs = builtins.removeAttrs args [ "crystal" ];
    githubLinks = lib.mapAttrsToList (name: value: {
        inherit name;
        path = fetchFromGitHub value;
    }) (import shardsFile);
    gitLinks = lib.mapAttrsToList (name: value: {
        inherit name;
        path = fetchgit { inherit (value) url rev sha256; };
    }) (import gitShardsFile);
    crystalLib = linkFarm "crystal-lib" (githubLinks ++ gitLinks);
    configurePhase = args.configurePhase or lib.concatStringsSep "\n" ([
        "runHook preConfigure"
    ] ++ lib.optional (lockFile != null)   "ln -s ${lockFile} ./shard.lock"
        ++ lib.optional (shardsFile != null) "ln -s ${crystalLib} lib"
	++ [ "runHook postConfigure "]);
in
    crystal.buildCrystalPackage (buildArgs // { inherit configurePhase; })
