# frozen_string_literal: true

describe CallRail::Client do
  let(:api_key) { ENV.fetch('CALL_RAIL_API_KEY') }
  let(:client) { described_class.new(api_key) }

  describe '.accounts' do
    subject { client.accounts }

    it { is_expected.to be_a(CallRail::Api::Accounts) }
  end

  describe '.trackers' do
    subject { client.trackers }

    it { is_expected.to be_a(CallRail::Api::Trackers) }
  end
end
