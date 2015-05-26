#This is the default JavaScriopt File for pSaMS.
log = (err) ->
  console.log err  if window.console and err
  return
$ ->
  #log "jQuery is ready!"
  $(".accordion").accordion header: ".title"
  $("#sidebar").height $("#body").height() - 16
	#$("#sidebar .accordion").height($("#body").height());
  $('.comment-form-submit').on('click', (evt)->
    evt.preventDefault()
    the_form = $(this).parents('form').first()
    form_data = the_form.serialize()
    $.post(the_form.prop('action'), form_data, (data)->
      $('.comments').append(data.html)
      $(this).closest('form').find("input[type=text], textarea").val("");
      console.info data
    )
  )

	$('.toggle').on('click', ->
		target = $(this).data('target')
		if $(target).is(':visible')
			$(target).data('disp',$(target).css('display'))
			$(target).css('display','none')
		else
			disp = $(target).data('disp')
			disp = 'block' unless disp
			$(target).css('display', disp)
  )
