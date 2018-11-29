const DSTest = artifacts.require("DSMath")

contract('Math', async (accounts) => {
    let math = null

    before(async () => {
        math = await DSTest.new()
    })

    it('add()', async() => {
        const onePlusOne = await math.add(1, 1)

        assert.equal(onePlusOne, 2, "add incorrect")
    })
})