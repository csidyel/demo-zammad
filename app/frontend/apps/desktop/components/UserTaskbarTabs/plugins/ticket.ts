// Copyright (C) 2012-2024 Zammad Foundation, https://zammad-foundation.org/

import { useConfirmation } from '#shared/composables/useConfirmation.ts'
import { TicketTaskbarTabAttributesFragmentDoc } from '#shared/entities/ticket/graphql/fragments/ticketTaskbarTabAttributes.api.ts'
import {
  EnumTaskbarEntity,
  type Ticket as TicketType,
} from '#shared/graphql/types.ts'

import type { UserTaskbarTabPlugin } from '#desktop/components/UserTaskbarTabs/types.ts'

import Ticket from '../Ticket/Ticket.vue'

const entityType = 'Ticket'

export default <UserTaskbarTabPlugin>{
  type: EnumTaskbarEntity.TicketZoom,
  component: Ticket,
  entityType,
  entityDocument: TicketTaskbarTabAttributesFragmentDoc,
  buildEntityTabKey: (entityInternalId: string) =>
    `${entityType}-${entityInternalId}`,
  buildTaskbarTabParams: (entityInternalId: string) => {
    return {
      ticket_id: entityInternalId,
    }
  },
  buildTaskbarTabLink: (entity?: TicketType, entityKey?: string) => {
    if (!entity?.internalId) {
      if (!entityKey) return
      return `/tickets/${entityKey.split('-')?.[1]}`
    }
    return `/tickets/${entity.internalId}`
  },
  confirmTabRemove: async (dirty?: boolean) => {
    if (!dirty) return true

    const { waitForVariantConfirmation } = useConfirmation()

    return waitForVariantConfirmation('unsaved')
  },
}
