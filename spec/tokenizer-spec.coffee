tokenizer = require('../lib/tokenizer')

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

  it "should return the right tokens", ->

    inString = 'Ext.define("some.class.name", {'
    tokens = tok.tokenize(inString)
