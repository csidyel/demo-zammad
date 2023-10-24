// Copyright (C) 2012-2023 Zammad Foundation, https://zammad-foundation.org/

import { useApolloClient } from '@vue/apollo-composable'
import { random } from 'lodash-es'
import type { RouteRecordRaw } from 'vue-router'
import LayoutTest from './LayoutTest.vue'
import mockApolloClient from '../mock-apollo-client.ts'
import renderComponent, { getTestRouter } from './renderComponent.ts'

vi.mock('#shared/server/apollo/client.ts', () => {
  return {
    clearApolloClientStore: () => {
      return Promise.resolve()
    },
    getApolloClient: () => {
      return {
        cache: {
          gc: () => [],
        },
      }
    },
  }
})

Object.defineProperty(window, 'fetch', {
  value: (path: string) => {
    throw new Error(`calling fetch on ${path}`)
  },
  writable: true,
  configurable: true,
})

const html = String.raw

interface VisitViewOptions {
  mockApollo?: boolean
}

export const visitView = async (
  href: string,
  options: VisitViewOptions = { mockApollo: true },
) => {
  const { routes } = await import('#mobile/router/index.ts')

  if (options.mockApollo) {
    mockApolloClient([])
  }

  // remove LayoutMain layout, keep only actual content
  if (routes.at(-1)?.name === 'Main') {
    const [mainRoutes] = routes.splice(routes.length - 1, 1)

    routes.push(...(mainRoutes.children as RouteRecordRaw[]), {
      path: '/testing-environment',
      component: {
        template: '<div></div>',
      },
    })
  }

  const testKey = random()

  const view = renderComponent(
    {
      template: html`<LayoutTest />`,
      components: { LayoutTest },
    },
    {
      store: true,
      router: true,
      form: true,
      unmount: true,
      routerRoutes: routes,
      propsData: {
        testKey,
      },
    },
  )

  const { client } = useApolloClient()
  await client.clearStore()

  const router = getTestRouter()

  await router.replace(href)

  return view
}
