@Record = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record
  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: React.findDOMNode(@refs.title).value
      date: React.findDOMNode(@refs.date).value
      amount: React.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data
  recordRow: ->
    <tr>
      <td>{@props.record.date}</td>
      <td>{@props.record.title}</td>
      <td>{amountFormat(@props.record.amount)}</td>
      <td>
        <a className="btn btn-default" onClick={@handleToggle}>Edit</a>
        <a className="btn btn-danger" onClick={@handleDelete}>Delete</a>
      </td>
    </tr>
  recordForm: ->
    <tr>
      <td>
        <input className="form-control" type="text" defaultValue={@props.record.date} ref="date" />
      </td>
      <td>
        <input className="form-control" type="text" defaultValue={@props.record.title} ref="title" />
      </td>
      <td>
        <input className="form-control" type="text" defaultValue={@props.record.amount} ref="amount" />
      </td>
      <td>
        <a className="btn btn-default" onClick={@handleEdit}>Update</a>
        <a className="btn btn-danger" onClick={@handleToggle}>Cancel</a>
      </td>
    </tr>
  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()