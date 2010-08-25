$(document).ready(function() {

    var exposure_count = 0 


    function create_new_exposure_from_resource(){
        exposure_number = exposure_count;
        exposure_count = exposure_count + 1;
        $('#exposures').append(
            $('<div class="exposure" id="exposure' + exposure_number + '"></div>').append(
                $(' <strong>Title</strong>: <input id="exposure_' + exposure_number + '_title" name="exposures[' + exposure_number + '][title]" size="30" type="text" value="' + $('#promotion_title').val() + '" />' +
                    ' <strong>Blurb</strong>: <input id="exposure_' + exposure_number + '_blurb" name="exposures[' + exposure_number + '][title]" size="40" type="text" value="' + $('#promotion_blurb').val() + '" />' +
                    ' <strong>Image Path</strong>: <input id="exposure_' + exposure_number + '_image" name="exposures[' + exposure_number + '][exturnal_image_url]" size="30" type="text" value="' + $('#promotion_external_image_url').val() + '" />'+
                    ' <strong>Steam</strong>: <select name="exposures[' + exposure_number + '][stream_id]">' +
                    '     <option name="live">Live Stream</option>' +
                    '     <option name="hero">Hero Promotion Stream</option>' +
                    '     <option name="promo">Promotion Stream</option>' +
                    '</select>'
                    )
                )
            );
    }

    $('#add_new_exposure').click(function(){
        create_new_exposure_from_resource();
    });

    


    $("DIV.container_panel > DIV.collapse_panel_header > DIV.arrow_expand").toggle(
        function() {
            $(this).parent().next("div.content").show("slow");
            $(this).attr("class", "arrow_close");
        },
        function() {
            $(this).parent().next("div.content").hide("slow")
            $(this).attr("class", "arrow_expand");
        });


    



});