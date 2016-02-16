{nameSpacePath} = require '../lib/helpers.coffee'

describe "nameSpacePath", ->
  it "should return the right thing", (done) ->
    nameSpaces = [
      name: 'MyNs',
      path: '/some/folder/there'
    ,
      name: 'MyNs2',
      path: '/some/different/folder'
    ]

    filePath = '/some/folder/there/view/Class.js'
    nspath = nameSpacePath(filePath, nameSpaces)
    expect(nspath).toBe('MyNs.view.Class')
