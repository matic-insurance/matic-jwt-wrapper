# frozen_string_literal: true

module Grape
  module Middleware
    module Auth
      class Strategies
        def self.add(_, _, _); end
      end
    end
  end
end

require 'spec_helper'
require 'matic-jwt/grape/middleware/auth'
require 'matic-jwt/grape/middleware/request'

RSpec.describe MaticJWT::Grape::Middleware::Auth do
  let(:instance) { described_class.new(app, options) }

  describe '#call' do
    subject(:authenticate) { instance.call(env) }

    let(:app) { double(:app, call: true) }
    let(:options) { { secret: ->(_) { secret } } }
    let(:env) { { 'HTTP_AUTHORIZATION' => "Bearer #{token}" } }
    let(:token) { MaticJWT::Generator.new.token_for(client_name, secret) }
    let(:client_name) { 'amp' }
    let(:secret) { 'secret' }

    context 'success' do
      before { authenticate }

      it 'calls app with env' do
        expect(app).to have_received(:call) do |env|
          expect(env['auth_payload']['client_name']).to eq client_name
        end
      end
    end

    context 'without header' do
      let(:env) { { 'HTTP_AUTHORIZATION' => nil } }

      it 'raise an error' do
        expect { authenticate }
          .to raise_error(JWT::VerificationError,
                          'Authorization token is invalid')
      end

      describe 'env' do
        before { safe_authenticate }

        it { expect(env['auth_payload']).to be_nil }
      end
    end

    context 'with different secret' do
      let(:options) { { secret: ->(_) { 'another_secret' } } }

      it 'raise an error' do
        expect { authenticate }
          .to raise_error(JWT::VerificationError,
                          'Signature verification raised')
      end

      describe 'env' do
        before { safe_authenticate }

        it 'set auth payload' do
          expect(env['auth_payload']).to include('client_name' => client_name)
        end
      end
    end

    def safe_authenticate
      authenticate
    rescue StandardError
      # ignored
    end
  end
end
