require 'spec_helper'

RSpec.describe MaticJWT::Authenticator do
  let(:instance) { described_class.new(request) }

  let(:request) { double(headers: {'Authorization' => "Bearer: #{token}"}) }
  let(:token) { MaticJWT::Generator.new.token_for(client_name, secret) }

  let(:client_name) { 'servicing' }
  let(:secret) { 'secret' }

  context 'without authorization header' do
    let(:request) { double(headers: {}) }

    it 'raises an error on initialization' do
      expect { described_class.new(request) }.to raise_error(JWT::DecodeError, 'Authorization header is missing')
    end
  end

  describe '#client_name' do
    it 'puts correct client_name inside payload' do
      expect(instance.client_name).to eq client_name
    end
  end

  describe '#authenticate_with_secret!' do
    subject(:authenticate) { instance.authenticate_with_secret!(decode_secret) }

    let(:decode_secret) { secret }

    it 'authenticates correctly' do
      expect { authenticate }.not_to raise_error
    end

    context 'with incorrect secret' do
      let(:decode_secret) { 'incorrect_secret' }

      it 'raises an error' do
        expect { authenticate }.to raise_error(JWT::VerificationError, 'Signature verification raised')
      end
    end
  end
end
