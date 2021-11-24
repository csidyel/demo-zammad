// Copyright (C) 2012-2021 Zammad Foundation, https://zammad-foundation.org/

import { createApp } from 'vue'
import App from '@mobile/App.vue'
import {
  DefaultApolloClient,
  provideApolloClient,
} from '@vue/apollo-composable'
import apolloClient from '@common/server/apollo/client'
import useSessionIdStore from '@common/stores/session/id'
import '@common/styles/main.css'
import initializeStore from '@common/stores'
import initializeStoreSubscriptions from '@common/initializer/storeSubscriptions'
import useApplicationConfigStore from '@common//stores/application/config'
import initializeRouter from '@common/router/index'
import routes from '@mobile/router'
import { i18n } from '@common/utils/i18n'
import useLocaleStore from '@common/stores/locale'

const enableLoadingAnimation = (): void => {
  const loadingElement: Maybe<HTMLElement> =
    document.getElementById('loadingApp')

  if (loadingElement) {
    loadingElement.style.display = 'flex'
  }
}

export default async function mountApp(): Promise<void> {
  const app = createApp(App)

  enableLoadingAnimation()

  app.provide(DefaultApolloClient, apolloClient)

  provideApolloClient(apolloClient)

  initializeStore(app)
  initializeRouter(app, routes)

  initializeStoreSubscriptions()

  const sessionId = useSessionIdStore()
  await sessionId.checkSession()

  const applicationConfig = useApplicationConfigStore()
  await applicationConfig.getConfig()

  app.config.globalProperties.i18n = i18n

  // Store subscriptions will set the locale for authenticated users,
  //  do it manually here only if the user is not authenticated.
  if (!sessionId.value) {
    useLocaleStore().updateLocale()
  }

  app.mount('#app')
}