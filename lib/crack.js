(function() {
  var Document, libxmljs;

  libxmljs = require('libxmljs');

  Document = (function() {

    function Document(data) {
      this._root = libxmljs.parseXmlString(data.trim()).root();
      this._ns = this._root.namespace();
    }

    Document.prototype.find = function(key, process) {
      var node, nodes, _i, _len, _results;
      nodes = this._ns ? this._root.find("//xmlns:" + key, this._ns.href()) : this._root.find("//" + key);
      _results = [];
      for (_i = 0, _len = nodes.length; _i < _len; _i++) {
        node = nodes[_i];
        if (process) {
          _results.push(process(this._parse(node)));
        } else {
          _results.push(this._parse(node));
        }
      }
      return _results;
    };

    Document.prototype.toJS = function() {
      return this._parse(this._root);
    };

    Document.prototype._parse = function(node) {
      var attr, child, key, obj, val, _i, _j, _len, _len2, _ref, _ref2;
      obj = {};
      _ref = node.attrs();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        attr = _ref[_i];
        obj[attr.name()] = attr.value();
      }
      _ref2 = node.childNodes();
      for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
        child = _ref2[_j];
        key = child.name();
        if (key === 'text') {
          val = child.text();
          if (Object.keys(obj).length === 0) {
            obj = val;
          } else {
            obj['__content'] = val;
          }
        } else {
          val = this._parse(child);
          if (obj[key]) {
            if (obj[key].constructor !== Array) obj[key] = [obj[key]];
            obj[key].push(val);
          } else {
            obj[key] = val;
          }
        }
      }
      return obj;
    };

    return Document;

  })();

  module.exports = function(data) {
    return new Document(data);
  };

}).call(this);
