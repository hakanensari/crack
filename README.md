# Crack

[![Build Status] [status]] [travis]

Really simple XML parsing with [libxmljs] [libxmljs].

## Installation

```bash
npm install crack
```

## Usage

```coffee
crack = require 'crack'

data = '<?xml version="1.0" encoding="UTF-8"?>' +
       '<Items>' +
       '<Item>' +
       '<ASIN>0816614024</ASIN>' +
       '<ItemAttributes>' +
       '<Creator Role="Author">Gilles Deleuze</Creator>' +
       '<Creator Role="Contributor">Felix Guattari</Creator>' +
       '<Title>Thousand Plateaus</Title>' +
       '</ItemAttributes>' +
       '</Item>' +
       '</Items>'
doc = crack data

# Convert entire document to a JavaScript object.
console.dir doc.toJS()

# Drop down to a node.
doc.find 'Creator', (creator) ->
  console.dir creator
```

[status]: https://secure.travis-ci.org/hakanensari/crack.png
[travis]: http://travis-ci.org/hakanensari/crack
[libxmljs]: https://github.com/polotek/libxmljs
