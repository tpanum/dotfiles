{ config, pkgs, ... }:

{
  services.printing = {
    enable = true;
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
