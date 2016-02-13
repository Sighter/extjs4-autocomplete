tokenizer = require('../lib/tokenizer')
_ = require('lodash')
fs = require('fs')

if jasmine.version
  # console.log jasmine.version
else
  # console.log 'jasmine-version:' + jasmine.getEnv().versionString()

describe "Tokenizer", ->

  tok = tokenizer.Tokenizer

  it "should match properly", ->

    inString = 'Ext.define("some.class.name", {'
    result = tok.parse(inString)
    console.log result
    console.log _.map(result, (e) -> e.name)

  it "should return the right tokens", (done) ->

    ## console.log arguments

    fname = 'spec/testapp/app/view/Panel.js'
    inString = fs.readFileSync fname, 'utf8'

    # #inString = 'Ext.define("some.class.name", {'
    # tokens = tok.tokenize(inString)
    #
    # expect(tokens[0].name).toBe('blockcomment')
