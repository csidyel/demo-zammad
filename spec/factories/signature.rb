# Copyright (C) 2012-2025 Zammad Foundation, https://zammad-foundation.org/

FactoryBot.define do
  factory :signature do
    sequence(:name) { |n| "Test signature #{n}" }
    body            { '#{user.firstname} #{user.lastname}'.text2html } # rubocop:disable Lint/InterpolationCheck
    created_by_id   { 1 }
    updated_by_id   { 1 }
  end
end
