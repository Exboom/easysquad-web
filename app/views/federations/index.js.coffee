$("#feder_content").empty()
  .append("<%= escape_javascript(render(partial: "federation", object: @federations)) %>");