$ ->
  $(".sortable").sortable()
  $(".sortable").disableSelection()
  $('form').submit(
    () ->
      $('#ballot_data').val($(".sortable").sortable("serialize"))
  )
