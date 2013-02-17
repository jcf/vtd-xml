require 'spec_helper'

describe VTD::Xml do
  it 'has a version number' do
    VTD::Xml::VERSION.should_not be_nil
  end

  describe '.open' do
    it 'creates a new parser' do
      VTD::Xml::Parser.should_receive(:new).with('path.xml')
      VTD::Xml.open 'path.xml'
    end
  end
end
