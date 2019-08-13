$("#thisteamplrs").empty()
  .append("<%= escape_javascript(render partial: "teams/this_team_plrs",  object: @team) %>");
$("#plrreg").empty()
  .append("<%= escape_javascript(render partial: "teams/new_plr_reg", locals: {team: @team}) %>");
$("#flashmsg").append("<%= escape_javascript(render partial: 'layouts/flash_msg') %>");
setTimeout (->
  $('#my-alert').alert('close');
), 5000

