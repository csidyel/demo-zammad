# Copyright (C) 2012-2024 Zammad Foundation, https://zammad-foundation.org/

require 'whatsapp_sdk'

class Whatsapp::Client

  attr_reader :access_token, :client

  def initialize(access_token:)
    @access_token = access_token

    raise ArgumentError, __("The required parameter 'access_token' is missing.") if access_token.nil?

    @client = WhatsappSdk::Api::Client.new access_token
  end

  def log_request(response: nil)
    return if response.empty?

    Rails.logger.error "WhatsApp Client: remote response: #{response}"
  end

  def handle_error(response:)
    return if !response.error

    log_request response: response.raw_response

    message = response.error.message

    if response.error.respond_to?(:raw_data_response) &&
       (details = response.error.raw_data_response&.dig('error_data', 'details'))

      message = "#{message}: #{details}"
    end

    raise CloudAPIError.new(message, response.error)
  end

  class CloudAPIError < StandardError
    attr_reader :original_error

    def initialize(message, original_error)
      super(message)

      @original_error = original_error
    end

    def retryable?
      return true if !original_error

      # WhatsApp API returns code 100 for various input errors
      # Such as too long body or too large attachment
      original_error.code != 100
    end
  end

  protected

  def with_tmpfile(prefix:, &)
    Tempfile.create(prefix, &)
  end

end
