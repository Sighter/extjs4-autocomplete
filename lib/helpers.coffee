
# find a matching bracket using stack
#
# String -> Int -> Char -> Char -> Array -> Int
findMatchingBracket = (str, startIdx, bracket, closingBracket, stack) ->
  if startIdx >= str.length
    return false
  if stack.length == 0
    return startIdx

  if str[startIdx] == closingBracket
    stack.pop()
    return findMatchingBracket str, startIdx + 1, bracket, closingBracket, stack

  if str[startIdx] == bracket
    stack.push(str[startIdx])
    return findMatchingBracket str, startIdx + 1, bracket, closingBracket, stack

  return findMatchingBracket str, startIdx + 1, bracket, closingBracket, stack

mod = {}
mod.findMatchingBracket = findMatchingBracket
module.exports = mod
