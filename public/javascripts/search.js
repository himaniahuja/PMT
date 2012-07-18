$(document).ready(function(){
    $("#search_project").keyup(function(){
                if($("#search_project").val()!=""){
                  $.post('search_update', {search: $("#search_project").val()}, null, "script");
                }
            }
        );
});
