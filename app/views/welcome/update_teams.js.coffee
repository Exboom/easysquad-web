$("#myteam").empty().append('<option value="">Выберите команду</option>');
$("#myteam").append("<%= escape_javascript(render(:partial => @teamusrng_adm)) %>");
$("#enemyteam").empty().append('<option value="">Выберите соперника</option>');
#  .append("<%= escape_javascript(render(:partial => @alltournteams)) %>");