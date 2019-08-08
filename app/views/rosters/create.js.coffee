$("#appplr").empty()
  .append("<%= escape_javascript(render(partial: "appplayers", object: @players)) %>");
$("#tournplr").empty()
  .append("<%= escape_javascript(render(partial: "tournplayers", object: @tournplr)) %>");