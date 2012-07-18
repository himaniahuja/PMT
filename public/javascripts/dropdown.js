$.fn.postAjaxRequest = function() {
  var that = this;

  this.ready(function() {
    if (that.val()!=""&&that.val()!=null){
        $.post('dropdown_update', {phase_id: that.val()}, null, "script");  }
  });
  this.change(function() {
    if (that.val()!=""&&that.val()!=null){
        $.post('dropdown_update', {phase_id: that.val()}, null, "script");  }
  });

};

$.fn.estimateAjaxRequest = function() {
  var that = this;

  this.ready(function() {
    if (that.val()!=""&&that.val()!=null){
        $.post('estimations/dropdown_update', {complexity_id: that.val()}, null, "script");  }
  });
  this.change(function() {
    if (that.val()!=""&&that.val()!=null){
        $.post('estimations/dropdown_update', {complexity_id: that.val()}, null, "script");  }
  });

};


$.fn.typeAjaxRequest = function() {
  var that = this;

  this.change(function() {
    if (that.val()!=""&&that.val()!=null){

	    if(that.val() == "-1"){
		   $.post('dropdown_update', {deliverable_type_id: that.val()}, null, "script");
		    $("#new_deliverable_type").show();

		}
	    if(that.val() != "-1") {


		 $("#new_deliverable_type").hide();
        }
	}
  });

};

$(document).ready(function()
        {
            $("#estimation_complexity_id").estimateAjaxRequest();
        }
    );


$(document).ready(function()
        {
            $("#post_phase_id").postAjaxRequest();
        }
    );

$(document).ready(function()
        {
            $("#deliverable_deliverable_type_id").typeAjaxRequest();
        }
    );

