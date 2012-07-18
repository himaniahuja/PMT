$(function () {
  $("input#effort_date_of_logging").datepicker({
    showOn: "button",
    buttonImage: "/images/calendar.png",
    buttonImageOnly: true,
    dateFormat: "yy-mm-dd"
  });

  $("#project-select-wrapper").change(function () {
    $.get('/home/update_phase_select', { id : $($(this).children('select')[0]).val() }, null, 'script')
  })

  $("#phase-select-wrapper").change(function() {
    $.get('/home/update_deliverable_select', { id : $($(this).children('select')[0]).val() }, null, 'script')
  })
})

function update_effort_func(item) {
  $.post('/home/update_effort', { deliverable_id : $(item).attr('deliverable_id') }, null, 'script');
}