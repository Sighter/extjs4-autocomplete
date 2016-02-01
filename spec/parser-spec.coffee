parser = require('../lib/parser')
tokenizer = require('../lib/tokenizer')
fs = require('fs')

if jasmine.version
  console.log jasmine.version
else
  console.log 'jasmine-version:' + jasmine.getEnv().versionString()

describe "parser", ->

  tok = new tokenizer.Tokenizer(tokenizer.tokenclasses)

  it "should be able to parse classes", (done) ->

    fname = 'spec/testapp/app/view/Panel.js'
    inString = fs.readFileSync fname, 'utf8'
    tokens = tok.tokenize(inString)

    l = parser.constructList[0].match(tokens)
    expect(l).toEqual(4)
