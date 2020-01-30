require 'spec_helper'
require 'matic-jwt/grape/helper'

class TestClass
  include ::MaticJWT::Grape::Helper
end

RSpec.describe ::MaticJWT::Grape::Helper do
  subject(:instance) { TestClass.new }

  describe '#auth_payload' do
    let(:env) { { 'auth_payload' => { 'test_key' => 'test_value' } } }

    before { allow(instance).to receive(:env).and_return(env) }

    it { expect(instance.auth_payload['test_key']).to eq 'test_value' }
  end
end
