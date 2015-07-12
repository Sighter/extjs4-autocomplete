tokenizer = require('../lib/tokenizer')
fs = require('fs')

if jasmine.version
  console.log jasmine.version
else
  console.log 'jasmine-version:' + jasmine.getEnv().versionString()

describe "Some Tokens", ->

  tok = new tokenizer.Tokenizer()

  it "should match", ->
    inString = 'Ext.define("some.class.name", {'

    m = tokenizer.BaseToken.match(inString)
    expect(m).toEqual('E')

    m = tokenizer.DefineToken.match(inString)
    expect(m).toEqual('Ext.define')

describe "Tokenizer", ->

  tok = new tokenizer.Tokenizer(tokenizer.tokenclasses)

  it "should match properly", ->

    inString = 'Ext.define("some.class.name", {'
    [l, t] = tok.matchToken(inString)
    expect(t.name).toBe('define')
    expect(t.value).toBe('Ext.define')

  it "should return the right tokens", (done) ->

    console.log arguments

    fname = 'spec/testapp/app/view/Panel.js'
    inString = fs.readFileSync fname, 'utf8'

    #inString = 'Ext.define("some.class.name", {'
    tokens = tok.tokenize(inString)

    expect(tokens[0].name).toBe('blockcomment')
