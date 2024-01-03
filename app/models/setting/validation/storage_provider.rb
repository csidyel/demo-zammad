# Copyright (C) 2012-2024 Zammad Foundation, https://zammad-foundation.org/

class Setting::Validation::StorageProvider < Setting::Validation

  def run
    return result_success if value.blank?

    msg = verify_configuration
    return result_failed(msg) if !msg.nil?

    result_success
  end

  private

  def verify_configuration
    return if !value.eql?('S3')

    begin
      Store::Provider::S3.ping!
    rescue Store::Provider::S3::Error => e
      return e.message
    end

    nil
  end
end
