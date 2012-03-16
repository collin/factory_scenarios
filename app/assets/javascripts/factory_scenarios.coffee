jQuery ($) ->
  $("li a").on "click", (event) ->
    $(".current").removeClass("current")
    $(this).closest("li").addClass("current")


  $("iframe").attr "src", $(".current a:first-child").attr("href")
