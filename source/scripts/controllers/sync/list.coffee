class ListSync

  constructor: (@model) ->

  listen: =>
    @model.on 'create:model', (model) =>
      data = model.toJSON()
      delete data.id
      delete data.tasks
      @oncreate(model, data)

    @model.on 'change:model', @handleUpdate
    @model.on 'before:destroy:model', @ondestroy

  create: (item) =>
    @model.create(item)

  update: (item) =>
    model = @model.get(item.id)
    return unless model
    delete item.id
    model.setAttributes(item)

  destroy: (item) =>
    model = @model.get(item.id)
    return unless model
    model.destroy()

  handleUpdate: (model, key, value) =>
    data = {}
    data[key] = value
    @onupdate(model, data)

  # override these
  oncreate: null
  onupdate: null
  ondestroy: null



module.exports = ListSync
