# Copyright (C) 2012-2024 Zammad Foundation, https://zammad-foundation.org/

module Gql::Queries
  class AutocompleteSearch::User < BaseQuery

    description 'Search for users'

    argument :input, Gql::Types::Input::AutocompleteSearch::InputType, required: true, description: 'The input object for the autocomplete search'

    type [Gql::Types::AutocompleteSearch::UserEntryType], null: false

    def resolve(input:)
      input = input.to_h
      query = input[:query]
      limit = input[:limit] || 50

      return [] if query.strip.empty?

      post_process(find_users(query:, limit:), input: input)
    end

    def find_users(query:, limit:)
      ::User.search(
        query:,
        limit:,
        current_user: context.current_user,
      )
    end

    def post_process(results, input:)
      results.map { |user| coerce_to_result(user) }
    end

    def coerce_to_result(user)
      {
        value:   user.id,
        label:   label(user),
        heading: user.organization&.name,
        user:    user,
      }
    end

    private

    def label(user)
      return user.fullname if user.fullname.present?
      return user.phone if user.phone.present?

      user.login
    end
  end
end
