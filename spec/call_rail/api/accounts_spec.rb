# frozen_string_literal: true

describe CallRail::Api::Accounts do
  include_context 'DefaultData'
  around(:each) { |example| VCR.use_cassette(vcr_cassette, &example) }

  describe '.list' do
    let(:accounts) { described_class.new(client_without_account_id) }
    let(:vcr_cassette) { 'accounts/list' }

    subject { accounts.list }

    it { is_expected.not_to be_empty }
  end

  describe '.info' do
    let(:accounts) { described_class.new(client) }
    let(:vcr_cassette) { 'accounts/info' }

    subject { accounts.info }

    it do
      p subject
      is_expected.not_to be_empty
    end
  end
end
