// Copyright (C) 2012-2024 Zammad Foundation, https://zammad-foundation.org/

export interface ColorScheme {
  value: string
  range: number
  label: string
}

export interface ColorGroup {
  name: string
  values: ColorScheme[]
}
