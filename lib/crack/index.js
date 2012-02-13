(function() {
  var Document, parse;

  Document = require('./document');

  parse = function(data) {
    return new Document(data);
  };

  module.exports = parse;

}).call(this);
