$("#user_content").empty()
  .append("<%= escape_javascript(render(:partial => @users)) %>");