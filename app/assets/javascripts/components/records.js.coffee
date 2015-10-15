@Records = React.createClass
  getInitialState: ->
    records: @props.data
  getDefaultProps: ->
    records: []
  addRecord: (record) ->
    records = React.addons.update(@state.records, {$push: [record]});
    @setState records: records
  deleteRecord: (record) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, {$splice: [[index, 1]]})
    @replaceState records: records
  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records
  render: ->
    <div className="records">
      <h2 className="title">Records</h2>
      <div className="row">
        <AmountBox type="success" amount={@credits()} text="Credit"/>
        <AmountBox type="danger" amount={@debits()} text="Debit"/>
        <AmountBox type="info" amount={@balance()} text="Balance"/>
      </div>
      <RecordForm handleNewRecord={@addRecord} />
      <hr />
      <table className="table table-bordered">
        <thead>
          <tr>
            <th>Date</th>
            <th>Title</th>
            <th>Amount</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {
            for record in @state.records
              <Record key={record.id} record={record} handleDeleteRecord={@deleteRecord} handleEditRecord={@updateRecord} />
          }
        </tbody>
      </table>
    </div>
  credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
      ), 0
  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
      ), 0
  balance: ->
    @debits() + @credits()