# Internal dependencies.
Document = require './document'

# Parses a string and returns an [XML document](./document.html).
parse = (data) ->
  new Document data
 
module.exports = parse
