ClasspathProvider = require('../lib/classpath-provider')

describe "ClasspathProvider", ->

  p = new ClasspathProvider([{
    name: 'Myapp'
    folder: 'testapp/app'
  }])

  it "should give the right suggestions", ->
    return

    got = p.getSuggestions({prefix: 'Myapp.'})
    expected = [
      text: 'view'
      type: 'package'
      rightLabel: 'Package'
    ,
      text: 'vimp'
      type: 'package'
      rightLabel: 'Package'
    ]
    expect(got).toEqual(expected)

    got = p.getSuggestions({prefix: 'Myapp.v'})
    expect(got).toEqual(expected)

    got = p.getSuggestions({prefix: 'Myapp.vi'})
    expect(got).toEqual(expected)

    got = p.getSuggestions({prefix: 'Myapp.ie'})
    expected = [
      text: 'view'
      type: 'package'
      rightLabel: 'Package'
    ]
    expect(got).toEqual(expected)

    got = p.getSuggestions({prefix: 'Myapp.view.'})
    expected = [
      text: 'Panel'
      type: 'class'
      rightLabel: 'Class'
    ]
    expect(got).toEqual(expected)

  it "should give null on nonsense", ->

    got = p.getSuggestions({prefix: 'Myappp.'})
    expect(got).toEqual([])

    got = p.getSuggestions({prefix: 'Myapp.vimp.'})
    expect(got).toEqual([])

    got = p.getSuggestions({prefix: 'Ext.'})
    expect(got).toEqual([])
