$ ->
  # Add scroll to widgets
  $(".dialogs,.comments,.survey_comments_charts .widget-body").slimScroll height: "300px"

  # Sparklines
  $(".sparkline").each ->
    $box = $(this).closest(".infobox")
    barColor = (if not $box.hasClass("infobox-dark") then $box.css("color") else "#FFF")
    $(this).sparkline "html",
      tagValuesAttribute: "data-values"
      type: "bar"
      barColor: barColor
      chartRangeMin: $(this).data("min") or 0

  # Add remote tabs to bootstrap
  $("a[data-toggle='tab'].ajaxTab").click (e) ->
    thisTab    = e.target
    pageTarget = $(thisTab).attr("data-tabUrl")
    tabId      = $(thisTab).attr("href")

    $(tabId).load pageTarget
