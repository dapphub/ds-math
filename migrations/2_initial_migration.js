var DSMathL = artifacts.require("./DSMathL.sol");
var DSMath = artifacts.require("./DSMath.sol");
var DSMathTest = artifacts.require("./DSMathTest.sol");

module.exports = function(deployer) {
  deployer.then(async () => { //fake async await support: https://github.com/trufflesuite/truffle/issues/501
    //deploy library
    await deployer.deploy(DSMathL)

    //link library
    await deployer.link(DSMathL, DSMath)
    await deployer.link(DSMathL, DSMathTest)
  })
}
