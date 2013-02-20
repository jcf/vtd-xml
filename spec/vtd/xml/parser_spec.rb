require 'spec_helper'

describe VTD::Xml::Parser do
  let(:parser) { VTD::Xml::Parser.new 'spec/fixtures/books.xml' }
  let(:book) { parser.find('//book[1]').first }

  it 'will pull everything that matches your XPath' do
    expect(parser.find('//book/author').to_a.length).to eq(3)
  end

  it 'yields a node for each match' do
    parser.find('//book/author').with_index do |node, index|
      expect(node.name).to eq('author')
      expect(node.text).to be_nil
    end
  end
end
