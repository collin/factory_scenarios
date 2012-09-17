jQuery ($) ->
  $("li a").click (event) ->
    if $(this).data('open_in_iframe') == 'true'
      $(".current").removeClass("current")
      $(this).closest("li").addClass("current")
      $("iframe").attr "src", $(".current a:first-child").attr("href")
    else
      console.log(this)
      window.location = this.href
