$("#enemyteam").empty()
  .append("<%= escape_javascript(render(:partial => @alltournteams)) %>");