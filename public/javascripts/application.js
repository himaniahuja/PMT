$(function() {
    $( "input#project_start_date" ).datepicker({
                   showOn: "button",
                   buttonImage: "/images/calendar.png",
                   buttonImageOnly: true,
                   dateFormat: "yy-mm-dd"
           });
    $( "input#project_estimated_end_date" ).datepicker({
                   showOn: "button",
                   buttonImage: "/images/calendar.png",
                   buttonImageOnly: true,
                   dateFormat: "yy-mm-dd"
           });
});

jQuery.ajaxSetup({
  'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
});


function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("true");
  $(link).closest(".phase").hide();
}

function update_position_values() {
    $("div.phase").each(function(index, value) {
          $(".position-field", value).val(index);
      });

}

function init_phase_sortables() {
    $("div.phases-panel").sortable({
          opacity: 0.7
      });
    $("div.phases-panel").bind("sortstop", function(event, ui) {
       update_position_values();
    });
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(".phases-panel").append(content.replace(regexp, new_id));

  $("div.phases-panel").sortable("refresh");
  update_position_values();
}