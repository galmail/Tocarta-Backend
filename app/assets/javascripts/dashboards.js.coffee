$ ->
  # Add scroll to widgets
  $(".dialogs,.comments").slimScroll height: "300px"

  # Sparklines
  $(".sparkline").each ->
    $box = $(this).closest(".infobox")
    barColor = (if not $box.hasClass("infobox-dark") then $box.css("color") else "#FFF")
    $(this).sparkline "html",
      tagValuesAttribute: "data-values"
      type: "bar"
      barColor: barColor
      chartRangeMin: $(this).data("min") or 0
