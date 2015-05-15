require 'spec_helper'
require 'tempfile'

describe EndiciaLabelServer::Connection do
  before do
    Excon.defaults[:mock] = true
  end

  after do
    Excon.stubs.clear
  end

  let(:stub_path) { File.expand_path("../../stubs", __FILE__) }
  let(:server) { EndiciaLabelServer::Connection.new(test_mode: true) }

  context "when setting test mode" do
    subject { EndiciaLabelServer::Connection.new(test_mode: true) }

    it "should set the uri to the test url" do
      expect(subject.url).to eql EndiciaLabelServer::Connection::TEST_URL
    end
  end

  context "when setting live mode" do
    subject { EndiciaLabelServer::Connection.new }

    it "should set the uri to the live url" do
      expect(subject.url).to eql EndiciaLabelServer::Connection::LIVE_URL
    end
  end

  context "if requesting a rates for a specific service" do
    before do
      Excon.stub({:method => :post}) do |params|
        case params[:path]
        when "#{EndiciaLabelServer::Connection::ROOT_PATH}#{EndiciaLabelServer::Connection::REQUEST_RATE_ENDPOINT}"
          {body: File.read("#{stub_path}/postage_rate_success.xml"), status: 200}
        end
      end
    end

    subject do
      server.rate do |rate_builder|
        rate_builder.add :certified_intermediary, {
          account_id: ENV['ENDICIA_ACCOUNT_ID'],
          pass_phrase: ENV['ENDICIA_PASS_PHRASE'],
          token: ENV['ENDICIA_TOKEN']
        }
        rate_builder.add :requester_id, ENV['ENDICIA_REQUESTER_ID']
        rate_builder.add :mail_class, EndiciaLabelServer::SERVICES.keys.first
        rate_builder.add :mailpiece_dimensions, {
          length: '10',
          width: '10',
          height: '10'
        }
        rate_builder.add :weight_oz, "2"
        rate_builder.add :from_postal_code, '90210'
        rate_builder.add :to_postal_code, '02215'
        rate_builder.add :to_country_code, 'US'
      end
    end

    it "should return a single rate" do
      expect { subject }.not_to raise_error
      expect(subject.rated_shipments).not_to be_empty
      expect(subject.rated_shipments.count).to eql 1
      expect(subject.rated_shipments).to eql [
        {:service_code=>"PriorityExpress", :service_name=>"Priority Mail Express", :total=>"27.68"}
      ]
    end
  end

  context "if requesting multiple rates" do
    before do
      Excon.stub({:method => :post}) do |params|
        case params[:path]
        when "#{EndiciaLabelServer::Connection::ROOT_PATH}#{EndiciaLabelServer::Connection::REQUEST_RATES_ENDPOINT}"
          {body: File.read("#{stub_path}/postage_rates_success.xml"), status: 200}
        end
      end
    end

    subject do
      server.rates do |rate_builder|
        rate_builder.add :certified_intermediary, {
          account_id: ENV['ENDICIA_ACCOUNT_ID'],
          pass_phrase: ENV['ENDICIA_PASS_PHRASE'],
          token: ENV['ENDICIA_TOKEN']
        }
        rate_builder.add :requester_id, ENV['ENDICIA_REQUESTER_ID']
        rate_builder.add :mail_class, "Domestic"
        rate_builder.add :mailpiece_dimensions, {
          length: '10',
          width: '10',
          height: '10'
        }
        rate_builder.add :weight_oz, "2"
        rate_builder.add :from_postal_code, '90210'
        rate_builder.add :to_postal_code, '02215'
        rate_builder.add :to_country_code, 'US'
      end
    end

    it "should return a single rate" do
      expect { subject }.not_to raise_error
      expect(subject.rated_shipments).not_to be_empty
      expect(subject.rated_shipments.count).to eql 6
      expect(subject.rated_shipments).to eql [
        {:total=>"1.93", :service_code=>"First", :service_name=>"First-Class Mail"},
        {:total=>"6.51", :service_code=>"Priority", :service_name=>"Priority Mail"},
        {:total=>"27.68", :service_code=>"PriorityExpress", :service_name=>"Priority Mail Express"},
        {:total=>"2.56", :service_code=>"LibraryMail", :service_name=>"Library Mail"},
        {:total=>"2.69", :service_code=>"MediaMail", :service_name=>"Media Mail"},
        {:total=>"6.68", :service_code=>nil, :service_name=>"Parcel Select Barcoded Nonpresorted"}
      ]
    end
  end
end
