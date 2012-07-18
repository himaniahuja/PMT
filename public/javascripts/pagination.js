$(function() {
  $(".apple_pagination a").live("click", function() {
    $(".apple_pagination").html("Loading...");
    $.getScript(this.href);
    return false;
  });
});