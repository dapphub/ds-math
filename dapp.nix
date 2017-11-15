dapp: with dapp; solidityPackage {
  name = "ds-math";
  deps = with dappsys; [ds-test];
  src = ./src;
}
