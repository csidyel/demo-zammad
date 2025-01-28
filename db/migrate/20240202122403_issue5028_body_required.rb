# Copyright (C) 2012-2025 Zammad Foundation, https://zammad-foundation.org/

class Issue5028BodyRequired < ActiveRecord::Migration[7.0]
  def change
    # return if it's a new setup
    return if !Setting.exists?(name: 'system_init_done')

    field = ObjectManager::Attribute.for_object('TicketArticle').find_by(name: 'body')
    field.screens['create_middle'] = { '-all-' => { 'null' => false } }
    field.save!
  end
end
