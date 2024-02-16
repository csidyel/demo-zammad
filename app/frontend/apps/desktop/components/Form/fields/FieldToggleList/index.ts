// Copyright (C) 2012-2024 Zammad Foundation, https://zammad-foundation.org/

import createInput from '#shared/form/core/createInput.ts'
import formUpdaterTrigger from '#shared/form/features/formUpdaterTrigger.ts'
import FieldToggleListInput from './FieldToggleListInput.vue'

const fieldDefinition = createInput(FieldToggleListInput, ['options'], {
  features: [formUpdaterTrigger()],
})

export default {
  fieldType: 'toggleList',
  definition: fieldDefinition,
}
