# You should not make any changes to this file.
#
# This file uses Coffeescript instead if Javascript beause I (SB) just find
# Coffeescript more convenient.

chai = require "chai"
chai.use require "chai-http"
should = chai.should()
assert = chai.assert

server = require "../index"

# Mocha can work either with promises or with callbacks (but not both).
# Some calls below are wrapped with this function to ensure that the
# the promises which chai functions return are discarded (we return null
# instead).
#
noReturnValue = (f) -> f(); null

validateHttp = (err, res) ->
  assert.isNull err
  assert.equal res.status, 200

describe "Dummy test...", ->
  it "shouldn't really do anythng", (done) ->
    noReturnValue -> done()
