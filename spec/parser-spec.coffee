parser = require('../lib/parser')
tokenizer = require('../lib/tokenizer')
fs = require('fs')

if jasmine.version
  # console.log jasmine.version
else
  # console.log 'jasmine-version:' + jasmine.getEnv().versionString()

describe "RegexParser", ->
  it "should be able to parse expressions", (done) ->
    instring = "Ext.define('My.fancy.Class', {"
    rp = new parser.RegexParser(/^Ext\.define/, 'define')
    result = rp.parse(instring)
    expect(result[0].remaining).toBe("('My.fancy.Class', {")

describe "SymbolParser", ->
  it "should be able to parse expressions", (done) ->
    instring = "{ name: "
    rp = new parser.SymbolParser('{', 'bracket')
    result = rp.parse(instring)
    expect(result[0].remaining).toBe(" name: ")
    expect(result[0].name).toBe("bracket")
    expect(result[0].consumed).toBe("{")

describe "Many", ->
  it "should be able to parse expressions", (done) ->
    p = new parser.SymbolParser('a', 'a')
    many = new parser.Many(p)
    result = many.parse("aaabbbb")
    expect(result.length).toBe(3)
    result = many.parse("bbbba")
    expect(result.length).toBe(0)

describe "Choice", ->
  it "should be able to parse expressions", (done) ->
    ap = new parser.SymbolParser('a', 'a')
    bp = new parser.SymbolParser('b', 'b')
    choice = new parser.Choice([ap, bp])
    result = choice.parse("aaabbbb")
    expect(result.length).toBe(1)
    expect(result[0].name).toBe('a')
    result = choice.parse("bbbba")
    expect(result.length).toBe(1)
    expect(result[0].name).toBe('b')

describe "Choice and Many", ->
  it "should be combineable", (done) ->
    ap = new parser.SymbolParser('a', 'a')
    bp = new parser.SymbolParser('b', 'b')
    choice = new parser.Choice([ap, bp])
    comb = new parser.Many(choice)
    result = comb.parse("aaabbbb")
    expect(result.length).toBe(7)
    expect(result[0].name).toBe('a')
