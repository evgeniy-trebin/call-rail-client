# frozen_string_literal: true

module CallRail
  module Api
    class Base

      URL = 'https://api.callrail.com/v2/'

      attr_reader :client

      def initialize(client)
        @client = client
      end

      def get(path, options = {})
        json_body(request('get', path, options))
      end

      def post(path, options = {}, payload = {})
        json_body(request('post', path, options, payload))
      end

      def put(path, options = {}, payload = {})
        json_body(request('put', path, options, payload))
      end

      def delete(path, options = {})
        response = request('delete', path, options)
        response.code
      end

      private

      def request(method, path, options = {}, payload = {})
        endpoint = [URL, path, '.json'].compact.join
        options = init_options.merge(options)

        case method
        when 'get'
          RestClient.get(endpoint, options)
        when 'post'
          RestClient.post(endpoint, payload, options)
        when 'put'
          RestClient.put(endpoint, payload, options)
        when 'delete'
          RestClient.delete(endpoint, options)
        end
      end

      def init_options
        { authorization: authorization_header, content_type: :json, accept: :json, accept_encoding: 'utf-8' }
      end

      def authorization_header
        "Token token=#{client.api_key}"
      end

      def account_url_part
        "a/#{client.account_id}"
      end

      def json_body(response)
        JSON.parse(response.body)
      end

    end
  end
end
