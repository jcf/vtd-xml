require 'spec_helper'

describe VTD::Xml::Node do
  let(:parser) { VTD::Xml::Parser.new 'spec/fixtures/books.xml' }
  let(:book) { parser.find('//book[1]').first }

  describe 'node attributes' do
    let(:title)      { 'A Tale of Two Cities' }
    let(:sold)       { '200000000' }
    let(:published)  { '1859' }

    it 'can be accessed with []' do
      expect(book['title']).to eq(title)
    end

    it 'can be accessed with fetch' do
      expect(book.fetch('title')).to eq(title)
    end

    it 'uses the second argument when fetch fails' do
      expect(book.fetch('not-present', 'Arg')).to eq('Arg')
    end

    it 'uses a block when fetch fails' do
      expect(book.fetch('not-present') { 'Block' }).to eq('Block')
    end

    it 'can slice attributes' do
      expect(book.slice('title', 'sold')).to eq(
        'title' => title, 'sold' => sold)
    end

    it 'can return all attributes' do
      expect(book.attributes).to eq(
        'title' => title, 'sold' => sold, 'firstPublished' => published, 'rank' => '1')
    end
  end

  describe '#children' do
    it 'filters children by name' do
      expect(book.children(only: 'rating').to_a.size).to eq(3)
    end

    it 'iterates through all child elements when no element name is given' do
      expect(book.children.to_a.size).to eq(7)
    end

    it 'is enumerable' do
      expect(book.children).to respond_to(:map)
    end

    it 'return an empty array when no matches are found' do
      expect(book.children(only: 'soundtrack').to_a).to eq([])
    end

    it 'doesnt affect existing node traversal' do
      ranks = parser.find('//book').map do |book|
        book.children.to_a
        book['rank']
      end

      expect(ranks).to eq(%w(1 2 3))
    end
  end
end
