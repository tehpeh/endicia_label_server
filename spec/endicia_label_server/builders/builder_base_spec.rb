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
end
