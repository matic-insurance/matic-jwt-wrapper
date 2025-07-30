# frozen_string_literal: true

require 'spec_helper'
require 'matic-jwt/grape/middleware/request'

RSpec.describe MaticJWT::Grape::Middleware::Request do
  shared_examples_for 'grape request' do |auth_header_key|
    let(:instance) { described_class.new(env) }
    let(:env) { { auth_header_key => 'Basic token' } }

    describe '#valid?' do
      subject { instance.valid? }

      it { is_expected.to be_truthy }

      context 'without header' do
        let(:env) { {} }

        it { is_expected.to be_falsey }
      end

      context 'with empty header' do
        let(:env) { { auth_header_key => nil } }

        it { is_expected.to be_falsey }
      end
    end

    describe '#auth_token' do
      subject { instance.auth_token }

      it { is_expected.to eq 'Basic token' }
    end
  end

  it_behaves_like 'grape request', 'Authorization'
  it_behaves_like 'grape request', 'HTTP_AUTHORIZATION'
  it_behaves_like 'grape request', 'X-HTTP_AUTHORIZATION'
  it_behaves_like 'grape request', 'X_HTTP_AUTHORIZATION'
end
