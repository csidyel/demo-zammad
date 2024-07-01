# Copyright (C) 2012-2024 Zammad Foundation, https://zammad-foundation.org/

module HasTransactionDispatcher
  extend ActiveSupport::Concern

  included do
    after_create TransactionDispatcher
    after_update TransactionDispatcher
  end

end
