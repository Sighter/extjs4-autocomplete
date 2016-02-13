_ = require('lodash')
db = require('../lib/docblock-parser')
{RegexParser, Many, Choice} = require('../lib/parser')

mod = {}

mod.BaseToken = new RegexParser(/^./, 'any')
mod.DefineToken = new RegexParser(/^Ext\.define/, 'define')
mod.FunctionToken = new RegexParser(/^function/, 'function')

mod.String1 = new RegexParser(/^"[^"]*"/, 'string')
mod.String2 = new RegexParser(/^'[^']*'/, 'string')
mod.String = new Choice([mod.String1, mod.String2])

mod.Tokenizer = new Many(new Choice([
  mod.DefineToken,
  mod.String,
  mod.FunctionToken,
  mod.BaseToken
]))

# mod.tokenclasses = [
#   mod.StringToken
#   mod.BlockCommentToken
#   mod.FunctionToken
#   mod.DefineToken
#   mod.LiteralBracketToken
#   mod.ParenthesesToken
#   mod.ColonToken
#   mod.WordToken
#   mod.BaseToken
# ]

module.exports = mod
