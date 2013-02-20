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
        'title' => title, 'sold' => sold, 'firstPublished' => published)
    end
  end

  describe '#with_first_child' do
    it 'can access node child element' do
      book.with_first_child do |child|
        expect(child['name']).to eq('Charles Dickens')
      end
    end

    it 'can access node child elements' do
      book.with_first_child('publisher') do |child|
        expect(child.text).to eq('Chapman & Hall')
      end
    end

    it 'returns nil when no element is found' do
      expect { |b|
        book.with_first_child('soundtrack', &b)
      }.to_not yield_control
    end

    it 'returns the cursor back to the initial position' do
      book.with_first_child('publisher') {}

      expect { |b|
        book.with_first_child(&b)
      }.to yield_with_args

      book.with_first_child do |child|
        expect(child['name']).to eq('Charles Dickens')
      end
    end

    it 'returns the last accessed value' do
      expect(book.with_first_child { 'return value' }).to eq('return value')
    end
  end

  describe '#with_each_child' do
    let(:ratings) { [] }

    it 'iterates over child elements for a given element name' do
      ratings = book.children(only: 'rating').map do |child|
        child.text.to_i
      end

      expect(ratings).to eq([5,2,3])
    end

    it 'iterates through all child elements when no element name is given' do
      expect(book.children.to_a.size).to eq(7)
    end
  end
end
