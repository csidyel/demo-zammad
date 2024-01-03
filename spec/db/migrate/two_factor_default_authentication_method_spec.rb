# Copyright (C) 2012-2024 Zammad Foundation, https://zammad-foundation.org/

require 'rails_helper'

RSpec.describe TwoFactorDefaultAuthenticationMethod, db_strategy: :reset, type: :db_migration do
  let(:user_without_two_factor) { create(:user) }

  let(:user_with_two_factor) do
    user = create(:user)

    create(:user_two_factor_preference, :authenticator_app, user: user)

    user_preferences = user.reload.preferences
    user_preferences[:two_factor_authentication] = user.preferences[:two_factor_authentication].except(:default)
    user.update!(preferences: user_preferences)

    user
  end

  let(:user_with_two_factor_and_default_method) do
    user = create(:user)

    create(:user_two_factor_preference, :authenticator_app, user: user)
    security_key_pref = create(:user_two_factor_preference, :security_keys, user: user)

    user.reload.two_factor_update_default_method(security_key_pref.method)

    user
  end

  context 'when there are no users with two-factor authentication' do
    it 'does not change anything' do
      user_without_two_factor

      expect { migrate }.not_to change { user_without_two_factor.reload.preferences.dig(:two_factor_authentication, :default) }
    end
  end

  context 'when there are users with two-factor authentication' do
    it 'sets the default authentication method to the first one' do
      user_with_two_factor

      expect { migrate }.to change { user_with_two_factor.reload.preferences.dig(:two_factor_authentication, :default) }.from(nil).to('authenticator_app')
    end
  end

  context 'when there are users with two-factor authentication and a default method' do
    it 'does not change the already stored default two-factor authentication method' do
      user_with_two_factor_and_default_method

      expect { migrate }.not_to change { user_with_two_factor_and_default_method.reload.preferences.dig(:two_factor_authentication, :default) }
    end
  end
end
