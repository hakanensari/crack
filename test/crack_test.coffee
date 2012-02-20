crack  = require '../src/crack'

shouldBeOnCrack = ->
  describe '#toJS', ->
    it 'converts an XML document to a JavaScript object', ->
      @doc.toJS().should.be.an.instanceof Object

  describe '#find', ->
    it 'finds matching nodes', ->
      items = @doc.find('Item')
      items.should.not.be.empty

    it 'returns nested nodes with no siblings', ->
      item = @doc.find('Item')[0]
      item['ASIN'].should.be.a 'string'

    it 'parses nodes with siblings', ->
      item = @doc.find('Item')[0]
      item['ItemAttributes']['Creator'].should.not.be.empty

    it 'parses nodes with attributes', ->
      item = @doc.find('Item')[0]
      creator = item['ItemAttributes']['Creator'][0]
      creator['Role'].should.be.a 'string'
      creator['__content'].should.be.a 'string'

    describe 'when no matches are found', ->
      it 'returns an empty array', ->
        @doc.find('foo').should.eql []

    describe 'when given a function', ->
      it 'passes matches through it', ->
        asins = @doc.find 'Item', (item) -> item['ASIN']
        for asin in asins
          asin.should.match /^\w{10}$/

describe 'Document', ->
  describe 'given an XML document', ->
    beforeEach ->
      data = '<?xml version="1.0" encoding="UTF-8"?>' +
             '<ItemLookupResponse>' +
             '<Items>' +
             '<Item>' +
             '<ASIN>0816614024</ASIN>' +
             '<ItemAttributes>' +
             '<Creator Role="Author">Gilles Deleuze</Creator>' +
             '<Creator Role="Contributor">Felix Guattari</Creator>' +
             '<Title>Thousand Plateaus</Title>' +
             '</ItemAttributes>' +
             '</Item>' +
             '</Items>' +
             '</ItemLookupResponse>'
      @doc = crack data

    shouldBeOnCrack()

  describe 'given a namespaced XML document', ->
    beforeEach ->
      data = '<?xml version="1.0" encoding="UTF-8"?>' +
             '<ItemLookupResponse xmlns="http://webservices.example.com/">' +
             '<Items>' +
             '<Item>' +
             '<ASIN>0816614024</ASIN>' +
             '<ItemAttributes>' +
             '<Creator Role="Author">Gilles Deleuze</Creator>' +
             '<Creator Role="Contributor">Felix Guattari</Creator>' +
             '<Title>Thousand Plateaus</Title>' +
             '</ItemAttributes>' +
             '</Item>' +
             '</Items>' +
             '</ItemLookupResponse>'
      @doc = crack data

    shouldBeOnCrack()

  describe 'given a string that is not an XML document', ->
    it 'throws an error', ->
      (-> crack 'foo').should.throw
