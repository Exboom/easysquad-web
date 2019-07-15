$("#location_content").empty()
  .append("<%= escape_javascript(render partial: "locations", object: @locations) %>");
