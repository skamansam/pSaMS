#This is the default JavaScriopt File for pSaMS.
log = (err) ->
  console.log err  if window.console and err
  return
$ ->
  #log "jQuery is ready!"
  $(".accordion").accordion header: ".title"
  $("#sidebar").height $("#body").height() - 16
	#$("#sidebar .accordion").height($("#body").height());
  return



