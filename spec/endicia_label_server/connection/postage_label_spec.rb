require 'spec_helper'
require 'tempfile'

describe EndiciaLabelServer::Connection, '.get_label' do
  before do
    Excon.defaults[:mock] = true
  end

  after do
    Excon.stubs.clear
  end

  let(:stub_path) { File.expand_path("../../../stubs", __FILE__) }
  let(:server) { EndiciaLabelServer::Connection.new(test_mode: true) }

  context "if requesting multiple rates" do
    before do
      Excon.stub({:method => :post}) do |params|
        case params[:path]
        when "#{EndiciaLabelServer::Connection::ROOT_PATH}#{EndiciaLabelServer::Connection::GET_POSTAGE_LABEL_ENDPOINT}"
          {body: File.read("#{stub_path}/postage_label_success.xml"), status: 200}
        end
      end
    end

    subject do
      server.get_label do |b|
        b.add :test, 'true'
        b.add :account_id, ENV['ENDICIA_ACCOUNT_ID']
        b.add :requester_id, ENV['ENDICIA_REQUESTER_ID']
        b.add :pass_phrase, ENV['ENDICIA_PASS_PHRASE']
        b.add :mail_class, 'First'
        b.add :weight_oz, '10'
        b.add :from_company, 'Google Inc.'
        b.add :from_address1, '1600 Amphitheatre Parkway'
        b.add :from_city, 'Mountain View'
        b.add :from_state, 'CA'
        b.add :from_postal_code, '94043'
        b.add :return_company, 'Bobs Your Uncle Inc.'
        b.add :return_address1, '1600 Amphitheatre Parkway'
        b.add :return_city, 'Mountain View'
        b.add :return_state, 'CA'
        b.add :return_postal_code, '94043'
        b.add :to_address1, '389 Townsend Street'
        b.add :to_city, 'San Francisco'
        b.add :to_state, 'CA'
        b.add :to_postal_code, '94107'
        b.add :partner_transaction_id, 'ABC-EFG-10'
        b.add :partner_customer_id, ENV['ENDICIA_REQUESTER_ID']
      end
    end

    it "should return a single rate" do
      expect { subject }.not_to raise_error
      expect(subject.success?).to be_truthy
      expect(subject.pic).to eql '9400110200830721634283'
      expect(subject.tracking_number).to eql '9400110200830721634283'
      expect(subject.final_postage).to eql '2.93'
      expect(subject.transaction_id).to eql '12'
      expect(subject.transaction_date_time).to eql '20150518132421'
      expect(subject.postmark_date).to eql '20150518'
      expect(subject.postage_balance).to eql '39.35'
      expect(subject.cost_center).to eql '0'
      expect(subject.label).to be_a Tempfile
    end
  end
end
