{parse, constructList} = require('../lib/parser')
fs = require('fs')

if jasmine.version
  console.log jasmine.version
else
  console.log 'jasmine-version:' + jasmine.getEnv().versionString()

describe "testing", ->

  it "should match", ->
    fname = 'spec/testapp/app/view/Panel.js'
    inString = fs.readFileSync fname, 'utf8'

    console.log constructList

    parse inString, constructList
