require 'spec_helper'

describe EndiciaLabelServer::Service, '#all' do
  let(:mailpiece) { EndiciaLabelServer::Service::MailpieceShape.new(service_name) }
  let(:letter_mailpiece) { 'Letter' }
  let(:flat_mailpiece) { 'Flat' }
  let(:parcel_mailpiece) { 'Parcel' }
  let(:flatrate_mailpiece) { 'FlatRate' }
  let(:large_parcel_mailpiece) { 'LargeParcel' }
  let(:flat_rate_legal_envelope_mailpiece) { 'FlatRateLegalEnvelope' }
  let(:flatrate_envelope_mailpiece) { 'FlatRateEnvelope' }
  let(:flat_rate_padded_envelope_mailpiece) { 'FlatRatePaddedEnvelope' }
  let(:flat_rate_gift_card_envelope_mailpiece) { 'FlatRateGiftCardEnvelope' }
  let(:flat_rate_window_envelope_mailpiece) { 'FlatRateWindowEnvelope' }
  let(:flat_rate_cardboard_envelope_mailpiece) { 'FlatRateCardboardEnvelope' }
  let(:flat_rate_envelope_mailpiece) { 'FlatRateEnvelope' }
  let(:small_flat_rate_envelope_mailpiece) { 'SmallFlatRateEnvelope' }
  let(:small_flat_rate_box_mailpiece) { 'SmallFlatRateBox' }
  let(:medium_flat_rate_box_mailpiece) { 'MediumFlatRateBox' }
  let(:large_flat_rate_box_mailpiece) { 'LargeFlatRateBox' }
  let(:regional_rate_box_a_mailpiece) { 'RegionalRateBoxA' }
  let(:regional_rate_box_b_mailpiece) { 'RegionalRateBoxB' }


  subject { mailpiece.all }

  context "when service is Express Mail(Domestic)" do
    let(:service_name) { 'Express Mail' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([flat_mailpiece, parcel_mailpiece, large_parcel_mailpiece, flat_rate_legal_envelope_mailpiece, flat_rate_padded_envelope_mailpiece, flat_rate_gift_card_envelope_mailpiece, small_flat_rate_envelope_mailpiece])
    end
  end

  context "when service is Express Mail International" do
    let(:service_name) { 'Express Mail International' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([flat_mailpiece, parcel_mailpiece, flatrate_envelope_mailpiece, flat_rate_padded_envelope_mailpiece])
    end
  end

  context 'when the service is Priority Mail Express' do
    let(:service_name) { 'Priority Mail Express' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([flat_mailpiece, parcel_mailpiece, large_parcel_mailpiece, flat_rate_envelope_mailpiece, regional_rate_box_a_mailpiece, regional_rate_box_b_mailpiece])
    end
  end

  context 'when the service is Priority Mail Express International' do
    let(:service_name) { 'Priority Mail Express International'  }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([flat_mailpiece, parcel_mailpiece, flatrate_envelope_mailpiece, flat_rate_padded_envelope_mailpiece, regional_rate_box_a_mailpiece, regional_rate_box_b_mailpiece])
    end
  end

  context 'when the service is Priority Mail Express International' do
    let(:service_name) { 'First-Class Mail' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([letter_mailpiece, flat_mailpiece, parcel_mailpiece])
    end
  end

  context 'when the service is Library Mail' do
    let(:service_name) { 'Library Mail' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([parcel_mailpiece])
    end
  end

  context 'when the service is Media Mail' do
    let(:service_name) { 'Media Mail' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([parcel_mailpiece])
    end
  end

  context 'when the service is Standard Post' do
    let(:service_name) { 'Standard Post' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([parcel_mailpiece, large_parcel_mailpiece])
    end
  end

  context 'when the service is Parcel Select' do
    let(:service_name) { 'Parcel Select' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([parcel_mailpiece, large_parcel_mailpiece])
    end
  end

  context 'when the service is Parcel Select Barcoded Nonpresorted' do
    let(:service_name) { 'Parcel Select Barcoded Nonpresorted' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([parcel_mailpiece, large_parcel_mailpiece])
    end
  end

  context 'when the service is Priority Mail' do
    let(:service_name) { 'Priority Mail' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([flat_mailpiece, parcel_mailpiece, large_parcel_mailpiece, flat_rate_legal_envelope_mailpiece, flat_rate_padded_envelope_mailpiece, flat_rate_gift_card_envelope_mailpiece, small_flat_rate_envelope_mailpiece, regional_rate_box_a_mailpiece, regional_rate_box_b_mailpiece])
    end
  end

  context 'when the service is Critical Mail' do
    let(:service_name) { 'Critical Mail' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([])
    end
  end

  context 'when the service is First-Class Mail International' do
    let(:service_name) { 'First-Class Mail International' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([letter_mailpiece, flat_mailpiece, parcel_mailpiece])
    end
  end

  context 'when the service is First-Class Package International Service' do
    let(:service_name) { 'First-Class Package International Service' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([letter_mailpiece, flat_mailpiece, parcel_mailpiece])
    end
  end

  context 'when the service is Priority Mail International' do
    let(:service_name) { 'Priority Mail International' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([flat_mailpiece, parcel_mailpiece, flat_rate_envelope_mailpiece, flat_rate_legal_envelope_mailpiece, flat_rate_padded_envelope_mailpiece, small_flat_rate_box_mailpiece, medium_flat_rate_box_mailpiece, large_flat_rate_box_mailpiece, regional_rate_box_a_mailpiece, regional_rate_box_b_mailpiece])
    end
  end

  context 'when the service is Priority Mail Express Flat Rate Envelope' do
    let(:service_name) { 'Priority Mail Express Flat Rate Envelope' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([flat_rate_envelope_mailpiece])
    end
  end

  context 'when the service is Priority Mail Flat Rate Envelope' do
    let(:service_name) { 'Priority Mail Flat Rate Envelope' }

    it "returns the valid mailpiece shapes for the service" do
      expect(subject).to match_array([flat_rate_envelope_mailpiece])
    end
  end
end
