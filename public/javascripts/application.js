$(document).ready(function() {

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