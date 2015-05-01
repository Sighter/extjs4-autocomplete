{filter} = require 'fuzzaldrin'
fs = require 'fs'
process = require 'process'

module.exports =
class ClasspathProvider
  selector: '.source.js'
  mapping: []
  candidates: []

  constructor: (mapping) ->
    @mapping = mapping
    @mapping.push({name: 'Ext', folder: null})

  getSuggestions: ({prefix, editor, bufferPosition, basePath}) ->

    if editor && bufferPosition
      prefix = @getPrefix editor, bufferPosition

    basePath = atom.project.getDirectories()[0].getPath() unless basePath
    console.log 'rootPath', rootPath

    classRegex = /\.js$/

    console.log 'prefix', prefix
    console.log 'cwd is: ', process.cwd()

    # convert prefix to path
    pathList = prefix.split "."
    console.log 'pathList', pathList
    realPrefix = pathList.pop()

    # swap root with real path
    root = pathList[0]
    rootPath = (i.folder for i in @mapping when i.name is root)[0]

    return [] unless rootPath

    pathList[0] = rootPath
    path = pathList.join('/')
    path = basePath + '/' + path
    console.log 'build path', path

    # check for files
    try
      candidates = fs.readdirSync(path)
    catch error
      candidates = []

    candidatesCleaned = []

    # build candidates
    for can in candidates

      if classRegex.test can
        newCan =
          text: can.replace classRegex, ''
          type: 'class'
          rightLabel: 'Class'

        candidatesCleaned.push newCan
      else
        newCan =
          text: can
          type: 'package'
          rightLabel: 'Package'

        candidatesCleaned.push newCan

    # fuzzy match
    filtered = filter(candidatesCleaned, realPrefix, key: 'text')
    res = (item for item in filtered)

  getPrefix: (editor, bufferPosition) ->
    # Whatever your prefix regex might be
    regex = /[\w0-9_.-]+$/

    # Get the text for the line up to the triggered buffer position
    line = editor.getTextInRange([[bufferPosition.row, 0], bufferPosition])

    # Match the regex to the line, and return the match
    line.match(regex)?[0] or ''
