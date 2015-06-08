require 'spec_helper'

describe EndiciaLabelServer::Builders::BuilderBase do
  describe '.add_array' do
    let(:builder) { EndiciaLabelServer::Builders::BuilderBase.new 'MyBuilder' }

    subject { builder.to_xml.gsub(/\s+/, "") }

    before do
      builder.add_array :test, ['1', '2']
    end

    it "should return valid XML" do
      should eql '<MyBuilder><Test><TestID>1</TestID><TestID>2</TestID></Test></MyBuilder>'
    end
  end

  describe '.add_hash' do
    context "When passed symbolized keys" do
      let(:builder) { EndiciaLabelServer::Builders::BuilderBase.new 'MyBuilder' }

      subject { builder.to_xml.gsub(/\s+/, "") }

      before do
        builder.add_hash :test, { id: '1', source: 'test' }
      end

      it "should return valid XML" do
        should eql '<MyBuilder><Test><ID>1</ID><Source>test</Source></Test></MyBuilder>'
      end
    end

    context "When passed string keys" do
      let(:builder) { EndiciaLabelServer::Builders::BuilderBase.new 'MyBuilder' }

      subject { builder.to_xml.gsub(/\s+/, "") }

      before do
        builder.add_hash 'TestTest', { 'ID' => '1', 'SourceSource' => 'test' }
      end

      it "should return valid XML" do
        should eql '<MyBuilder><TestTest><ID>1</ID><SourceSource>test</SourceSource></TestTest></MyBuilder>'
      end
    end
  end
end
