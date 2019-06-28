$("#menu1").empty()
  .append("<%= escape_javascript(render(:partial => @usersNew[0])) %>");
$("#numeric").empty()
  .append("<%= @usersNew.size %>");