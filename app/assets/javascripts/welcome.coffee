# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'change', '#tourn', (evt) ->
    $.ajax 'welcome/update_teams',
      type: 'GET'
      dataType: 'script'
      data: {
        tournament_id: $("#tourn option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic team select OK!")

$ ->
  $(document).on 'change', '#myteam', (evt) ->
    $.ajax 'welcome/update_enemy',
      type: 'GET'
      dataType: 'script'
      data: {
        tournament_id: $("#tourn option:selected").val()
        myteam_id: $("#myteam option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic team select OK!")