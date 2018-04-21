# frozen_string_literal: true

module CallRail
  class Client

    attr_reader :api_key, :account_id

    def initialize(api_key, account_id = nil)
      @api_key = api_key
      @account_id = account_id
    end

    %w[accounts].each do |endpoint|
      define_method endpoint do
        if instance_variable_defined?("@#{endpoint}")
          instance_variable_get("@#{endpoint}")
        else
          klass = "::CallRail::Api::#{endpoint.camelize}".constantize
          instance_variable_set("@#{endpoint}", klass.new(self))
        end
      end
    end

  end
end
