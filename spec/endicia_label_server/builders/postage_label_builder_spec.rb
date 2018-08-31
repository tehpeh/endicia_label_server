require 'spec_helper'

describe EndiciaLabelServer::Builders::PostageLabelBuilder do
  def dump_xml(builder)
    builder.to_xml(indent: -1).strip
  end

  describe 'when building an international postage label request with customs items' do
    let(:root_attributes) { { label_type: 'International' } }
    let(:options) do
      {
        foo: 'bar',
        customs_info: {
          contents_type: 'Merchandise',
          customs_items: [
            { customs_item: { weight: '2', description: 'A great cup' } },
            { customs_item: { weight: '3', description: 'Another great cup' } }
          ]
        }
      }
    end
    let(:builder) { EndiciaLabelServer::Builders::PostageLabelBuilder.new options, root_attributes }

    subject { dump_xml(builder) }

    it "should return valid XML" do
      should eql '<LabelRequest LabelType="International"><Foo>bar</Foo><CustomsInfo><ContentsType>Merchandise</ContentsType><CustomsItems><CustomsItem><Weight>2</Weight><Description>A great cup</Description></CustomsItem><CustomsItem><Weight>3</Weight><Description>Another great cup</Description></CustomsItem></CustomsItems></CustomsInfo></LabelRequest>'
    end
  end
end
