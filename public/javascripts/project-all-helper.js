function js_archive(tag) {
  var proj_id = $(tag).attr('data-id');
  $.post('/projects/' + proj_id + '/archive', { id : proj_id }, null, 'script');
  if ($(tag).text() == "Archive") {
    $(tag).text("Unarchive");
  } else {
    $(tag).text("Archive");
  }
}
