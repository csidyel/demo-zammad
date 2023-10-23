// Copyright (C) 2012-2023 Zammad Foundation, https://zammad-foundation.org/

import { FieldResolverRichtext } from '../richtext.ts'

describe('FieldResolverRichtext', () => {
  it('should return the correct field attributes', () => {
    const fieldResolver = new FieldResolverRichtext({
      dataType: 'richtext',
      name: 'body',
      display: 'Body',
      dataOption: {
        type: 'richtext',
        maxlength: 150_000,
        upload: true,
        rows: 8,
        null: true,
      },
      isInternal: true,
    })

    expect(fieldResolver.fieldAttributes()).toEqual({
      label: 'Body',
      name: 'body',
      required: false,
      props: {},
      type: 'editor',
      internal: true,
    })
  })
})
