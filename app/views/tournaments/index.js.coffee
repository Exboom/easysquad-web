$("#tournament_content").empty()
  .append("<%= escape_javascript(render(partial: "tournament", object: @tournaments)) %>");
