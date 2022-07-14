RSpec.describe Beds24::JSONClient do
  include_context 'responses'

  subject { described_class.new auth_token }
  let(:auth_token) { 'dummytoken' }

  describe '#initialize' do
    it 'accepts auth token' do
      expect{ subject }.not_to raise_error
    end
  end

  describe 'accessors' do
    let(:new_auth_token) { 'newdummytoken' }
    it 'allows to access token' do
      expect(subject.auth_token).to eq auth_token
    end

    it 'allows to set token' do
      client = subject
      client.auth_token = new_auth_token
      expect(client.auth_token).to eq new_auth_token
    end
  end

  describe '#get_properties' do
    context 'without key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getProperties"
        ).with(body: subject.send(:authentication).to_json).to_return(body: {
          error: 'Unauthorized',
          errorCode: '1000'
        }.to_json)
      end

      it 'returns unauthorized message' do
        expect(subject.get_properties).to eq ({
          'error' => 'Unauthorized',
          'errorCode' => '1000'
        })
      end
    end

    context 'with key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getProperties"
        ).with(body: subject.send(:authentication).to_json).to_return(body: properties.to_json)
      end

      it 'returns list of properties' do
        expect(subject.get_properties).to eq (properties['getProperties'])
      end
    end
  end

  describe '#get_property' do
    context 'without key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getProperty"
        ).with(
          body: subject.send(:authentication, '111')
            .merge(Beds24::Constants::DEFAULT_PROPERTY_OPTIONS)
            .to_json
        ).to_return(body: {
          error: 'Unauthorized',
          errorCode: '1000'
        }.to_json)
      end

      it 'returns unauthorized message' do
        expect(subject.get_property('111')).to eq ({
          'error' => 'Unauthorized',
          'errorCode' => '1000'
        })
      end
    end

    context 'with key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getProperty"
        ).with(
          body: subject.send(:authentication, '111')
            .merge(Beds24::Constants::DEFAULT_PROPERTY_OPTIONS)
            .to_json
        ).to_return(body: property.to_json)
      end

      it 'returns property' do
        expect(subject.get_property('111')).to eq property['getProperty'].first
      end
    end
  end
  
  describe '#get_property_content' do
    context 'without key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getPropertyContent"
        ).with(
          body: subject.send(:authentication, '111')
            .merge(Beds24::Constants::DEFAULT_PROPERTY_OPTIONS)
            .to_json
        ).to_return(body: {
          error: 'Unauthorized',
          errorCode: '1000'
        }.to_json)
      end

      it 'returns unauthorized message' do
        expect(subject.get_property_content('111')).to eq ({
          'error' => 'Unauthorized',
          'errorCode' => '1000'
        })
      end
    end

    context 'with key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getPropertyContent"
        ).with(
          body: subject.send(:authentication, '111')
            .merge(Beds24::Constants::DEFAULT_PROPERTY_OPTIONS)
            .to_json
        ).to_return(body: property_content.to_json)
      end

      it 'returns property_content' do
        expect(subject.get_property_content('111')).to eq property_content['getPropertyContent'].first
      end
    end
  end
  
    describe '#get_rates' do
    context 'without key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getRates"
        ).with(
          body: subject.send(:authentication, '111')
            .merge(Beds24::Constants::DEFAULT_PROPERTY_OPTIONS)
            .to_json
        ).to_return(body: {
          error: 'Unauthorized',
          errorCode: '1000'
        }.to_json)
      end

      it 'returns unauthorized message' do
        expect(subject.get_rates('111')).to eq ({
          'error' => 'Unauthorized',
          'errorCode' => '1000'
        })
      end
    end

    context 'with key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getRates"
        ).with(
          body: subject.send(:authentication, '111')
            .merge(Beds24::Constants::DEFAULT_PROPERTY_OPTIONS)
            .to_json
        ).to_return(body: rates.to_json)
      end

      it 'returns rates' do
        expect(subject.get_rates('111')).to eq rates['getRates'].first
      end
    end
  end

  describe '#get_bookings' do
    context 'without key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getBookings"
        ).with(
          body: subject.send(:authentication, '111')
            .merge(Beds24::Constants::DEFAULT_BOOKING_OPTIONS)
            .to_json
        ).to_return(body: {
          error: 'Unauthorized',
          errorCode: '1000'
        }.to_json)
      end

      it 'returns unauthorized message' do
        expect(subject.get_bookings('111')).to eq ({
          'error' => 'Unauthorized',
          'errorCode' => '1000'
        })
      end
    end

    context 'with key' do
      before(:each) do
        stub_request(
          :post,
          "#{Beds24::Constants::JSON_API_ENDPOINT}/getBookings"
        ).with(
          body: subject.send(:authentication, '111')
            .merge(Beds24::Constants::DEFAULT_BOOKING_OPTIONS)
            .to_json
        ).to_return(body: bookings.to_json)
      end

      it 'returns property' do
        expect(subject.get_bookings('111')).to eq bookings
      end
    end
  end
end
