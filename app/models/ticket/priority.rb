# Copyright (C) 2012-2025 Zammad Foundation, https://zammad-foundation.org/

class Ticket::Priority < ApplicationModel
  include HasDefaultModelUserRelations

  include CanBeImported
  include ChecksHtmlSanitized
  include HasCollectionUpdate
  include HasSearchIndexBackend

  self.table_name = 'ticket_priorities'
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  after_create  :ensure_defaults
  after_update  :ensure_defaults
  after_destroy :ensure_defaults

  validates :note, length: { maximum: 250 }
  sanitized_html :note

  attr_accessor :callback_loop

  def ensure_defaults
    return true if callback_loop

    priorities_with_default = Ticket::Priority.where(default_create: true)
    return true if priorities_with_default.count == 1

    if priorities_with_default.count.zero?
      priority = Ticket::Priority.where(active: true).reorder(id: :asc).first
      priority.default_create = true
      priority.callback_loop = true
      priority.save!
      return true
    end

    if priorities_with_default.count > 1
      Ticket::Priority.all.each do |local_priority|
        next if local_priority.id == id

        local_priority.default_create = false
        local_priority.callback_loop = true
        local_priority.save!
      end
    end
    true
  end
end
