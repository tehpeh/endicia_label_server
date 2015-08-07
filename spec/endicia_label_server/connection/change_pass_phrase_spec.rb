require 'spec_helper'
require 'tempfile'
require 'faker'

describe EndiciaLabelServer::Connection, '.change_pass_phrase' do
  before do
    Excon.defaults[:mock] = true
  end

  after do
    Excon.stubs.clear
  end

  let(:stub_path) { File.expand_path("../../../stubs", __FILE__) }
  let(:server) { EndiciaLabelServer::Connection.new(test_mode: true) }

  context "when changing a users pass phrase" do
    before do
      Excon.stub({:method => :post}) do |params|
        case params[:path]
        when "#{EndiciaLabelServer::Connection::ROOT_PATH}#{EndiciaLabelServer::Connection::CHANGE_PASS_PHRASE_ENDPOINT}"
          {body: File.read("#{stub_path}/change_pass_phrase_success.xml"), status: 200}
        end
      end
    end

    subject do
      server.change_pass_phrase do |connection|
        connection.add :requester_id, ENV['ENDICIA_REQUESTER_ID']
        connection.add :request_id, 'ABC'
        connection.add :certified_intermediary, {
          account_id: '1234567',
          pass_phrase: 'SUPER SECRET AND SECURE PASSWORD',
          token: 'AGAIN ANOTHER AWESOME SECRET TOKEN'
        },
        new_pass_phrase: 'iAmAPassword1_c'
      end
    end

    it "should return a single rate" do
      expect { subject }.not_to raise_error
      expect(subject.success?).to be_truthy
    end
  end
end
