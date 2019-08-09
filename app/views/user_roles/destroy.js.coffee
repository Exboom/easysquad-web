$("#adminsteam").empty()
  .append("<%= escape_javascript(render(partial: "admteam")) %>");