mod = {}

class mod.DocBlocParser

  @param: /@param\s+{([^} ]*)}\s+(\w*)\s+(.*)/
  @return: /@return\s+{([^} ]*)}\s+(.*)/
  @tag: /@\w*/

  @parse: (string) ->
    lines = string.split '\n'

    docbloc = {
      description: ''
      params: {}
    }
    description = true

    for l in lines
      if description
        firstTag = l.match @tag
        if firstTag == null
          desc = l.replace(/^[^\w]*/, '')
          if docbloc.description == ''
            docbloc.description += desc
          else
            docbloc.description += ' ' + desc
        else
          description = false

      m = l.match @param
      if m
        docbloc.params[m[2]] = {}
        docbloc.params[m[2]].type = m[1]
        docbloc.params[m[2]].description = m[3]
        continue

      m = l.match @return
      if m
        docbloc.return = {}
        docbloc.return.type = m[1]
        docbloc.return.description = m[2]
        continue

    return docbloc

module.exports = mod
