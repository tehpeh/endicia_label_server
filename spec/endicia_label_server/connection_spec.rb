require 'spec_helper'
require 'tempfile'
require 'faker'

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

  context "if signing up a new user" do
    before do
      Excon.stub({:method => :post}) do |params|
        case params[:path]
        when "#{EndiciaLabelServer::Connection::ROOT_PATH}#{EndiciaLabelServer::Connection::GET_USER_SIGNUP_ENDPOINT}"
          {body: File.read("#{stub_path}/user_sign_up_success.xml"), status: 200}
        end
      end
    end

    subject do
      server.sign_up do |b|
        b.add :requester_id, ENV['ENDICIA_REQUESTER_ID']
        b.add :request_id, 'ABC'
        b.add :first_name, Faker::Name.first_name
        b.add :middle_name, Faker::Name.first_name
        b.add :last_name, Faker::Name.last_name
        b.add :title, Faker::Name.prefix
        b.add :email_address, Faker::Internet.email
        b.add :phone_number, Faker::PhoneNumber.phone_number
        b.add :phone_number_ext, Faker::PhoneNumber.extension
        b.add :fax_number, Faker::PhoneNumber.phone_number
        b.add :partner_id, ENV['ENDICIA_REQUESTER_ID']
        b.add :originating_ip_address, Faker::Internet.ip_v4_address
        b.add :contracts, {
          contact_id: 'CID78786'
        }
        b.add :account_credentials, {
          web_password: Faker::Internet.password(8),
          temporary_pass_phrase: Faker::Internet.password(8),
          security_question: 'What is love?',
          security_answer: 'Baby dont hurt me, no more'
        }
        b.add :physical_address, {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          company_name: Faker::Company.name,
          suite_or_apt: '21',
          address: '389 Townsend Street',
          city: 'San Francisco',
          state: 'CA',
          zip5: '94107',
          phone: Faker::PhoneNumber.phone_number,
          extension: Faker::PhoneNumber.extension
        }
        b.add :mailing_address, {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          company_name: Faker::Company.name,
          suite_or_apt: '21',
          address: '389 Townsend Street',
          city: 'San Francisco',
          state: 'CA',
          zip5: '94107',
          phone: Faker::PhoneNumber.phone_number,
          extension: Faker::PhoneNumber.extension
        }
        b.add :credit_card, {
          credit_card_number: '4242-4242-4242-4242',
          credit_card_type: 'Visa',
          credit_card_month: Date::MONTHNAMES[Faker::Business.credit_card_expiry_date.month],
          credit_card_year: '2020',
          credit_card_address: '389 Townsend Street',
          credit_card_city: 'San Francisco',
          credit_card_state: 'CA',
          credit_card_zip5: '94107',
        }
        b.add :i_certify, "true"
      end
    end

    it "should return a single rate" do
      expect { subject }.not_to raise_error
      expect(subject.success?).to be_truthy
    end
  end
end
