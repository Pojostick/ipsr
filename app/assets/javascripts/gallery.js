$( function() {
    $('#colorcountslider').slider({
        min: 0,
        max: 22,
        range: true,
        values: [5, 10],
        slide: function( event, ui ) {
            $("#colorcount").text(ui.values[0] + " - " + ui.values[1]);
        }
    });
    $("#colorcount").text($('#colorcountslider').slider('values', 0) + " - " + $('#colorcountslider').slider('values', 1));

    $('#movescountslider').slider({
        min: 0,
        max: 205,
        range: true,
        values: [50, 100],
        step: 5,
        slide: function( event, ui ) {
            if (ui.values[0] >= 200 && ui.values[1] > 200) {
                $("#movescount").text("200+");
            } else if (ui.values[0] == ui.values[1]) {
                $("#movescount").text(ui.values[0]);
            } else {
                if (ui.values[1] > 200) {
                    $("#movescount").text(ui.values[0] + " - 200+");
                } else {
                    $("#movescount").text(ui.values[0] + " - " + ui.values[1]);
                }
            }
        }
    });
    $("#movescount").text($('#movescountslider').slider('values', 0) + " - " + $('#movescountslider').slider('values', 1));
});