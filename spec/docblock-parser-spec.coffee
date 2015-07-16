db = require('../lib/docblock-parser')

describe "the DocBlocParser", ->

  testcomment = """/**
    * this is the doc of myMethod
    *
    * @param  {String} arg1 some description
    * @param  {String} nodesc
    * @param  {Object} arg2 hello
    * @return {Ext.panel.Panel}      this is the return value
    */"""

  it "should parse tags", ->
    docbloc = db.DocBlocParser.parse testcomment

    expect(docbloc.description).toBe('this is the doc of myMethod')
    expect(docbloc.params.arg1).toBeDefined()
    expect(docbloc.params.arg2.type).toBe('Object')
    expect(docbloc.return.type).toBe('Ext.panel.Panel')
