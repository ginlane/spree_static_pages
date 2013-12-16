window.SpreeStaticPages.DateField = Ember.TextField.extend
  type: 'date'
  date: ((key, date) ->
    if date
      @set 'value', date.toISOString().substring(0, 10)
    else
      value = @get 'value'
      if value
        date = new Date(value)
      else
        date = null;
    date
  ).property 'value'
