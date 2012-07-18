
$(document).ready(function()
        {
            re="^[1-9]\d*\.\d*|0\.\d*[1-9]\d*|^[1-9]\d*|0";

            $(".calculation_size").keyup(function() {
                if($(".calculation_effort").val().match(re)&&$(".calculation_size").val().match(re)){
                    $(".calculation_rate").val(
                        $(".calculation_size").val()/$(".calculation_effort").val());
                }else{
                   if($(".calculation_rate").val().match(re)&&$(".calculation_size").val().match(re)){
                    $(".calculation_effort").val(
                        $(".calculation_size").val()/$(".calculation_rate").val());
                    }
                }
            });
            $(".calculation_effort").keyup(function() {
                if($(".calculation_effort").val().match(re)&&$(".calculation_size").val().match(re)){
                    $(".calculation_rate").val(
                        $(".calculation_size").val()/$(".calculation_effort").val());
                }else
                {
                  if($(".calculation_effort").val().match(re)&&$(".calculation_rate").val().match(re)){
                    $(".calculation_size").val(
                        $(".calculation_effort").val()*$(".calculation_rate").val());
                  }
                }
                });

              $(".calculation_rate").keyup(function() {
                  if($(".calculation_size").val().match(re)&&$(".calculation_rate").val().match(re)){
                      $(".calculation_effort").val(
                           $(".calculation_size").val()/$(".calculation_rate").val());
                  }else{
                      if($(".calculation_effort").val().match(re)&&$(".calculation_rate").val().match(re)){
                            $(".calculation_size").val(
                                $(".calculation_effort").val()*$(".calculation_rate").val());
                      }
                  }

                });

        }
    );