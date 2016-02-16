{readdir, readFile, nameSpacePath, nameSpaces} = require './helpers'
_ = require 'lodash'

mod = {}

# path -> path -> Promise
mod.dynamicSnippets = (snippedDir, className) ->
  return new Promise((resolve, reject) ->
    p = readdir(snippedDir)
    p.then((files) ->
      bodyPromises = _.map(files, (p) ->
        fileContentPromise = readFile(snippedDir.concat('/', p))
        return fileContentPromise.then((content) ->
          return {
            snippet: content
            displayText: p
          }
        )

      )
      Promise.all(bodyPromises).then((all) ->
        sugs = _.map(all, (obj) ->
          return {
            snippet: obj.snippet.replace(/%%classname%%/g, className)
            displayText: obj.displayText
            type: 'snippet'
          }
        )
        console.log 'Got strings: ', sugs
        resolve(sugs)
      )
    )
  )

class mod.DynamicSnippetsProvider
  selector: '.source.js, .source.gfm'

  getSuggestions: ({prefix, editor, bufferPosition, basePath}) ->
    # console.log "got prefix: ", prefix
    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer.file
    filePath = file?.path
    snippetDir = atom.packages.getPackageDirPaths()[0].concat('/extjs4-autocomplete/dynsnippets')
    nsp = nameSpaces(atom.project.getPaths()[0])
    p = nsp.then((ns) ->
      console.log 'retreiving snippets for:', snippetDir, ns, filePath
      return mod.dynamicSnippets(snippetDir, nameSpacePath(filePath, ns))
    )

module.exports = mod
