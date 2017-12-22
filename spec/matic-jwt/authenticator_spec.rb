require 'spec_helper'

RSpec.describe MaticJWT::Authenticator do
  let(:instance) { described_class.new(header) }

  let(:header) { "Bearer #{token}" }

  let(:token_generator) { MaticJWT::Generator.new }
  let(:token) { token_generator.token_for(client_name, secret) }

  let(:client_name) { 'servicing' }
  let(:secret) { 'secret' }

  context 'with empty header' do
    let(:header) { '' }

    it 'raises an error on initialization' do
      expect { instance }.to raise_error(JWT::DecodeError, 'Authorization token is incorrect')
    end
  end

  context 'with empty token' do
    let(:header) { 'Bearer ' }

    it 'raises an error on initialization' do
      expect { instance }.to raise_error(JWT::DecodeError, 'Authorization token is incorrect')
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

    context 'with overridden token type' do
      let(:instance) { described_class.new(header, scheme: 'Basic') }
      let(:header) { "Basic #{token}" }

      it 'works correctly' do
        expect { authenticate }.not_to raise_error
      end
    end

    context 'with overridden zero seconds expiration' do
      let(:token_generator) { MaticJWT::Generator.new(expiration: 0.seconds) }

      it 'raise an error' do
        expect { authenticate }.to raise_error(JWT::ExpiredSignature, 'Signature has expired')
      end
    end

    context 'with header generated with #authentication_header_for' do
      let(:header) { token_generator.authentication_header_for(client_name, secret) }

      it 'works correctly' do
        expect { authenticate }.not_to raise_error
      end

      context 'with custom token type' do
        let(:scheme) { 'Basic' }
        let(:instance) { described_class.new(header, scheme: scheme) }
        let(:header) { token_generator.authentication_header_for(client_name, secret, scheme: scheme) }

        it 'still works correctly' do
          expect { authenticate }.not_to raise_error
        end
      end
    end

    context 'with incorrect secret' do
      let(:decode_secret) { 'incorrect_secret' }

      it 'raises an error' do
        expect { authenticate }.to raise_error(JWT::VerificationError, 'Signature verification raised')
      end
    end

    context 'with nil header' do
      let(:header) { nil }

      it 'raises an error' do
        expect { authenticate }.to raise_error(JWT::DecodeError, 'Authorization token is incorrect')
      end
    end
  end
end
