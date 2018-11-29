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

    it('testFail_sub()', async() => {
        await shouldFail.reverting(math.testFail_sub())
    })

    it('test_sub()', async() => {
        await math.test_sub()
    })

    it('testFail_mul()', async() => {
        await shouldFail.reverting(math.testFail_mul())
    })

    it('test_mul()', async() => {
        await math.test_mul()
    })

    it('test_min()', async() => {
        await math.test_min()
    })

    it('test_max()', async() => {
        await math.test_max()
    })

    it('test_imin()', async() => {
        await math.test_imin()
    })

    it('test_imax()', async() => {
        await math.test_imax()
    })

    it('testFail_wmul_overflow()', async() => {
        await shouldFail.reverting(math.testFail_wmul_overflow())
    })

    it('test_wmul_trivial()', async() => {
        await math.test_wmul_trivial()
    })

    it('test_wmul_fractions()', async() => {
        await math.test_wmul_fractions()
    })

    it('testFail_wdiv_zero()', async() => {
        await shouldFail.reverting(math.testFail_wdiv_zero())
    })

    it('test_wdiv_trivial()', async() => {
        await math.test_wdiv_trivial()
    })

    it('test_wdiv_fractions()', async() => {
        await math.test_wdiv_fractions()
    })

    it('test_wmul_rounding()', async() => {
        await math.test_wmul_rounding()
    })

    it('test_rmul_rounding()', async() => {
        await math.test_rmul_rounding()
    })
})