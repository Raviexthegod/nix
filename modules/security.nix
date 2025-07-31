{...}: {
  security = {
    protectKernelImage = true;
    apparmor = {
      enable = true;
      enableCache = true;
      killUnconfinedConfinables = true;
    };
    tpm2 = {
      enable = true;
      abrmd.enable = true;
      applyUdevRules = true;
      pkcs11.enable = true;
      tssGroup = "tss";
    };
  };
}