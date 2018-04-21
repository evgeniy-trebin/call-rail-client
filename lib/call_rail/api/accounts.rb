# frozen_string_literal: true

module CallRail
  module Api
    class Accounts < Base

      def list
        get('a')
      end

      def info
        get(account_url_part)
      end

    end
  end
end
