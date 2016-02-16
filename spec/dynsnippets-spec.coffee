{dynamicSnippets} = require('../lib/dynsnippets')

describe "dynamicSnippets", ->
  it "should be to return", (done) ->
    p = dynamicSnippets('dynsnippets', 'blabla')
