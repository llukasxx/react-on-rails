@RecordForm = React.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount: ''
  render: ->
    <form className="form-inline" onSubmit={@handleSubmit}>
      <div className="form-group">
        <input type="text" className="form-control" placeholder="Date" 
        name="date" value={@state.date} onChange={@handleChange}/>
      </div>
      <div className="form-group">
        <input type="text" className="form-control" placeholder="Title" 
        name="title" value={@state.title} onChange={@handleChange}/>
      </div>
      <div className="form-group">
        <input type="number" className="form-control" placeholder="Amount" 
        name="amount" value={@state.amount} onChange={@handleChange}/>
      </div>
      <button type="submit" className="btn btn-primary" disabled={!@valid()}>
        Create record
      </button>
    </form>
  handleChange: (e)->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.title && @state.date && @state.amount
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/records', { record: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'