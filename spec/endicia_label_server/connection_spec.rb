require 'spec_helper'

describe EndiciaLabelServer::Connection do
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
end
