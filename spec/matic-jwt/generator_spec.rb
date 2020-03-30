require 'spec_helper'

RSpec.describe MaticJWT::Generator do
  let(:generator) { described_class.new }
  let(:client_name) { 'test_client' }
  let(:secret) { 'my top secret' }

  describe '.token_for' do
    subject(:token) { generator.token_for(client_name, secret, test: 'yes') }
    subject(:payload) { JWT.decode(token, nil, false).first }

    it 'adds client to payload' do
      expect(payload).to include('client_name' => client_name)
    end

    it 'adds expiration to payload' do
      expect(payload).to include('exp' => be_within(5).of(1.minute.since.to_i))
    end

    it 'adds additional info to payload' do
      expect(payload).to include('test' => 'yes')
    end

    it 'correctly signs request' do
      expect { JWT.decode(token, secret, true) }.not_to raise_error
    end
  end

  describe '.authentication_header_for' do
    subject(:header) { generator.authentication_header_for(client_name, secret, test: 'yes') }

    it 'adds scheme to output' do
      expect(header).to start_with('Bearer ')
    end

    it 'is verified' do
      authenticator = MaticJWT::Authenticator.new(header)
      expect { authenticator.authenticate_with_secret!(secret) }.not_to raise_error
    end
  end
end