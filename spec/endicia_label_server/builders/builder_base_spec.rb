require 'spec_helper'

describe EndiciaLabelServer::Builders::BuilderBase do
  def dump_xml(builder)
    builder.to_xml(indent: -1).strip
  end

  describe '.initialize' do
    let(:options) { { foo: 'bar' } }
    let(:root_attributes) { nil }
    let(:builder) { EndiciaLabelServer::Builders::BuilderBase.new('ABuilder', options, root_attributes) }

    subject { dump_xml(builder) }

    context 'when passed with root attributes' do
      let(:root_attributes) do
        {
          label_type: 'international',
          label_subtype: 'another'
        }
      end

      it 'adds the options as root attributes on the root object and returns valid XML' do
        should eql '<ABuilder LabelType="international" LabelSubtype="another"><Foo>bar</Foo></ABuilder>'
      end
    end
  end

  describe '.add' do
    context 'when the value type is a hash' do
      context "When passed symbolized keys" do
        let(:builder) { EndiciaLabelServer::Builders::BuilderBase.new 'MyBuilder' }

        subject { dump_xml(builder) }

        before do
          builder.add :test, { id: '1', source: 'test' }
        end

        it "should return valid XML" do
          should eql '<MyBuilder><Test><ID>1</ID><Source>test</Source></Test></MyBuilder>'
        end
      end

      context "When passed string keys" do
        let(:builder) { EndiciaLabelServer::Builders::BuilderBase.new 'MyBuilder' }

        subject { dump_xml(builder) }

        before do
          builder.add 'TestTest', { 'ID' => '1', 'SourceSource' => 'test' }
        end

        it "should return valid XML" do
          should eql '<MyBuilder><TestTest><ID>1</ID><SourceSource>test</SourceSource></TestTest></MyBuilder>'
        end
      end
    end

    context 'when the value type is an array' do
      let(:builder) { EndiciaLabelServer::Builders::BuilderBase.new 'MyBuilder' }

      subject { dump_xml(builder) }

      before do
        builder.add :test, [
          customs_item_1: {
            foo: 'bar'
          },
          customs_item_2: {
            another: 'value'
          }
        ]
      end

      it "should return valid XML" do
        should eql '<MyBuilder><Test><CustomsItem1><Foo>bar</Foo></CustomsItem1><CustomsItem2><Another>value</Another></CustomsItem2></Test></MyBuilder>'
      end
    end
  end
end
