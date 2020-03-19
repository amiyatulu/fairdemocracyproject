const ScoreBallot = artifacts.require("ScoreBallot")

contract("ScoreBallot", async accounts => {
  let admin
  it("commit phage length test", async () => {
    admin = accounts[0]
    notAdmin = accounts[1]

    let scoreBallotInstance = await ScoreBallot.deployed()
    await scoreBallotInstance.setCommitPhaseLengthInSeconds(5000)

    lengthsecs = await scoreBallotInstance.commitPhaseLengthInSeconds()
    console.log(lengthsecs.toString())
  })
})
