const DSMathTest = artifacts.require("DSMathTest")
let shouldFail = require('./helpers/shouldFail.js')

contract('DSMathTest', async (accounts) => {
    let math = null

    before(async () => {
        math = await DSMathTest.new()
    })

    it('testFail_add()', async() => {
        await shouldFail.reverting(math.testFail_add())
    })
})