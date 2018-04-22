# frozen_string_literal: true

RSpec.shared_context 'DefaultData' do
  let(:api_key) { ENV.fetch('CALL_RAIL_API_KEY') }
  let(:account_id) { ENV.fetch('CALL_RAIL_ACCOUNT_ID') }
  let(:client_without_account_id) { CallRail::Client.new(api_key) }
  let(:client) { CallRail::Client.new(api_key, account_id) }
end
