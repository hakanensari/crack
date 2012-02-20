# External dependencies.
libxmljs = require 'libxmljs'

# A minimum viable XML document.
class Document
  # Builds a document out of a string.
  constructor: (data) ->
    @_root = libxmljs.parseXmlString(data.trim()).root()
    @_ns   = @_root.namespace()

  # Queries for given node key and returns JavaScript object representations
  # of matching nodes.
  #
  # Optionally, passes nodes through a given function.
  find: (key, process) ->
    nodes =
      if @_ns
        @_root.find "//xmlns:#{key}", @_ns.href()
      else
        @_root.find "//#{key}"

    for node in nodes
      if process
        process @_parse node
      else
        @_parse node

  # Returns a JavaScript object representation of the document.
  toJS: ->
    @_parse @_root

  # This is an internal method used to convert an XML node to a JavaScript
  # object.
  _parse: (node) ->
    obj = {}

    for attr in node.attrs()
      obj[attr.name()] = attr.value()

    for child in node.childNodes()
      key = child.name()
      if key is 'text'
        val = child.text()
        if Object.keys(obj).length is 0
          obj = val
        else
          obj['__content'] = val
      else
        val = @_parse child
        if obj[key]
          obj[key] = [obj[key]] unless obj[key].constructor is Array
          obj[key].push val
        else
          obj[key] = val

    obj

module.exports = (data) ->
  new Document data
