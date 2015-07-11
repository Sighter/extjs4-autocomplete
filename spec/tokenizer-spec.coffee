tokenizer = require('../lib/tokenizer')

describe "Some Tokens", ->

  tok = new tokenizer.Tokenizer()

  it "should match", ->

    inString = 'Ext.define("some.class.name", {'
    m = new tokenizer.Matcher 'define', /^Ext\.define/

    token = tok.match(tokenizer.matchers, inString)

    expect(token.name).toEqual('define')
    expect(token.value).toEqual('Ext.define')


describe "Tokenizer", ->

  tok = new tokenizer.Tokenizer()

  it "should tokenize properly", ->

    inString = 'Ext.define("some.class.name", {'

    tok.tokenize(inString, tokenizer.tokens)
