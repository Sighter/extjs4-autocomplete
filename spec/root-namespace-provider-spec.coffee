RootNamespaceProvider = require('../lib/root-namespace-provider')

describe "RootNamespaceProvider", ->
  it "should be createable", ->

    p = new RootNamespaceProvider([{
      name: 'Myapp'
      folder: 'app'
    }])

    expect(p).toBeDefined()

  it "should give the right suggestions", ->

    p = new RootNamespaceProvider([{
      name: 'Myapp'
      folder: 'app'
    }])

    got = p.getSuggestions('My')
    expect(got).toEqual([{text: 'Myapp'}])

    got = p.getSuggestions('ap')
    expect(got).toEqual([{text: 'Myapp'}])

    got = p.getSuggestions('ex')
    expect(got).toEqual([{text: 'Ext'}])
