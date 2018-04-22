# frozen_string_literal: true

module CallRail
  module Api
    class Trackers < Base

      def list(opts = {})
        get(trackers_url_part, opts)
      end

      def info(tracker_id, opts = {})
        get(tracker_url_part(tracker_id), opts)
      end

      def create(opts = {})
        post(trackers_url_part, opts)
      end

      def update(tracker_id, opts = {})
        put(tracker_url_part(tracker_id), opts)
      end

      def disable(tracker_id, opts = {})
        delete(tracker_url_part(tracker_id), opts)
      end

      private

      def trackers_url_part
        account_url_part + '/trackers'
      end

      def tracker_url_part(id)
        trackers_url_part + "/#{id}"
      end

    end
  end
end
