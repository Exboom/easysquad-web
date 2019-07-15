$("#team_content").empty()
  .append("<%= escape_javascript(render partial: "teams", object: @teams) %>");
