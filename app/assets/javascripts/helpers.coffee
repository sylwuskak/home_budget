@setupCategorySelect = () ->
  select = $("select[id='operation_type'")
  select_value = $("select[id='operation_type'")[0]
  if(!select_value)
    return

  category_select_value = $("select[id='operation_category_id'")[0]

  $(select_value).change( ->
    v = select_value.value
    l = ''
    if (select_value.options[0].value == v) 
      l = select_value.options[0].label
    else 
      l = select_value.options[1].label
    

    if (l == category_select_value.children[0].label) 
      category_select_value.children[0].disabled = false
      category_select_value.children[1].disabled = true
    else
      category_select_value.children[0].disabled = true
      category_select_value.children[1].disabled = false
    

  )

@fixBootstrapTable = () ->
  console.log "AAAAAAAAAAAAAAAA"
  $('[data-search="true"]').bootstrapTable( ->
    console.log "AAAAAAAAAAAAAAAA"
    console.log locale
    if(locale == "pl") 
      locale: 'pl-PL'
    else 
      locale:'en-US'    
  )