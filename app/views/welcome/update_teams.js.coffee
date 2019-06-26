$("#enemyteam").empty()
  .append("<%= escape_javascript(render(:partial => @alltournteams)) %>");
$("#myteam").empty()
  .append("<%= escape_javascript(render(:partial => @teamusrng)) %>");