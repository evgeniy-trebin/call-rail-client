# frozen_string_literal: true

describe CallRail::Api::Calls do
  include_context 'DefaultData'

  let(:calls) { described_class.new(client) }
  let(:call_id) { 589800616 }

  around(:each) { |example| VCR.use_cassette(vcr_cassette, &example) }

  describe '.list' do
    let(:vcr_cassette) { 'calls/list' }

    subject { calls.list }

    it do
      expect(subject['calls'].count).to eq(2)
      expect(subject['page']).to eq(1)
      expect(subject['per_page']).to eq(100)
      expect(subject['total_records']).to eq(2)
    end

    context 'pagination' do
      let(:vcr_cassette) { 'calls/list_pagination' }

      subject { calls.list(params: { page: 2, per_page: 250 }) }

      it do
        expect(subject['calls'].count).to eq(0)
        expect(subject['page']).to eq(2)
        expect(subject['per_page']).to eq(250)
        expect(subject['total_records']).to eq(2)
      end
    end
  end

  describe '.info' do
    let(:vcr_cassette) { 'calls/info' }

    subject { calls.info(call_id) }

    it do
      expect(subject['id']).to eq(589800616)
      expect(subject['answered']).to be_truthy
    end
  end

  xdescribe '.create' # TODO: create
  xdescribe '.update' # TODO: update

  describe '.summary' do
    let(:vcr_cassette) { 'calls/summary' }

    subject { calls.summary(params: { group_by: :source }) }

    it { expect(subject['grouped_by']).to eq('source') }
  end

  describe '.timeseries' do
    let(:vcr_cassette) { 'calls/timeseries' }

    subject do
      fields = 'missed_calls,answered_calls,first_time_callers,average_duration,formatted_average_duration,leads'
      calls.timeseries(params: {
                         start_date: '2018-03-23',
                         end_date: '2018-04-22',
                         fields: fields
                       })
    end

    it { expect(subject['data'].count).to eq(31) }
  end

  describe '.recording' do
    let(:vcr_cassette) { 'calls/recording' }

    subject do
      calls.recording(call_id)
    end

    it { expect(subject['url']).to be_present }
  end
end
