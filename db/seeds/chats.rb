# Copyright (C) 2012-2025 Zammad Foundation, https://zammad-foundation.org/

Chat.create_if_not_exists(
  name:          'default',
  max_queue:     5,
  note:          '',
  active:        true,
  updated_by_id: 1,
  created_by_id: 1,
)
