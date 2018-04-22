# frozen_string_literal: true

module CallRail
  module Api
    class Calls < Base

      def list(opts = {})
        get(calls_url_part, opts)
      end

      def info(call_id, opts = {})
        get(call_url_part(call_id), opts)
      end

      def create(opts = {})
        post(calls_url_part, opts)
      end

      def update(call_id, opts = {})
        put(call_url_part(call_id), opts)
      end

      def summary(opts = {})
        get(calls_url_part + '/summary', opts)
      end

      def timeseries(opts = {})
        get(calls_url_part + '/timeseries', opts)
      end

      def recording(call_id, opts = {})
        get(call_url_part(call_id) + '/recording', opts)
      end

      private

      def calls_url_part
        account_url_part + '/calls'
      end

      def call_url_part(id)
        calls_url_part + "/#{id}"
      end

    end
  end
end
