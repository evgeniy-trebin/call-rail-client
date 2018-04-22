# frozen_string_literal: true

describe CallRail::Api::Trackers do
  include_context 'DefaultData'

  let(:trackers) { described_class.new(client) }

  around(:each) { |example| VCR.use_cassette(vcr_cassette, &example) }

  describe '.list' do
    let(:vcr_cassette) { 'trackers/list' }

    subject { trackers.list }

    it do
      expect(subject['trackers'].count).to eq(3)
      expect(subject['page']).to eq(1)
      expect(subject['per_page']).to eq(100)
      expect(subject['total_records']).to eq(3)
    end

    context 'pagination' do
      let(:vcr_cassette) { 'trackers/list_pagination' }

      subject { trackers.list(params: { page: 2, per_page: 250 }) }

      it do
        expect(subject['trackers'].count).to eq(0)
        expect(subject['page']).to eq(2)
        expect(subject['per_page']).to eq(250)
        expect(subject['total_records']).to eq(3)
      end
    end
  end

  describe '.info' do
    let(:tracker_id) { 677996186 }
    let(:vcr_cassette) { 'trackers/info' }

    subject { trackers.info(tracker_id) }

    it do
      expect(subject['id']).to eq(677996186)
      expect(subject['status']).to eq('disabled')
    end
  end
end
