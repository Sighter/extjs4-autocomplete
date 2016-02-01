{Context, parseNameSpace, completions} = require('../lib/completions.coffee')

describe "Context", ->

  it "should split input string correctly", ->

    c = new Context([], 'TeaFactory.tea.Darj')

    expect(c.path).toBe('TeaFactory.tea')
    expect(c.query).toBe('Darj')
    expect(c.nameSpaces).toEqual([])

describe "parseNameSpace", ->

  it "should give", ->

    io = parseNameSpace('spec/testapp/app/view')
    ret = io.run()

    expect(ret.length).toBe(2)
    console.log ret

describe "completions", ->

  it "should parse NameSpaces", ->

    c = new Context([{
      name: 'MyNs',
      path: 'spec/testapp/app/'
    }], 'MyNs.view.G')

    comps = completions(c)
    console.log comps
