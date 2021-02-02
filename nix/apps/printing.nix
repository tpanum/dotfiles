{ config, pkgs, ... }:

{
  services.printing = {
    enable = true;
    logLevel = "debug";
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      foomatic-filters
      hplip
      brlaser
      cups-brother-hll2340dw
    ];
  };
}
