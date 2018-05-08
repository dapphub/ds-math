{ solidityPackage, dappsys }: solidityPackage {
  name = "ds-math";
  deps = with dappsys; [ds-test];
  src = ./src;
}
