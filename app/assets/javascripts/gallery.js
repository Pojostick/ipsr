$( function() {
    var ai = parseInt($("#APPDATA").attr("complete_low"));
    var af = parseInt($("#APPDATA").attr("complete_high"));
    var bi = parseInt($("#APPDATA").attr("colorcount_low"));
    var bf = parseInt($("#APPDATA").attr("colorcount_high"));
    var ci = parseInt($("#APPDATA").attr("movescount_low"));
    var cf = parseInt($("#APPDATA").attr("movescount_high"));
    var di = parseInt($("#APPDATA").attr("timetaken_low"));
    var df = parseInt($("#APPDATA").attr("timetaken_high"));

    var render = function(display, max, low, high, units) {
        if (low >= max && high > max) {
            display.text(max + "+" + units);
        } else if (low == high) {
            display.text(low + units);
        } else if (high > max) {
                display.text(low + "+" + units);
        } else {
            display.text(low + " - " + high + units);
        }
    };

    $('#completeslider').slider({
        range: true,
        values: [ai, af],
        slide: function( event, ui ) {
            render($("#complete"), 100, ui.values[0], ui.values[1], "%");
        }
    });
    render($("#complete"), 100, ai, af, "%");

    $('#colorcountslider').slider({
        min: 0,
        max: 22,
        range: true,
        values: [bi, bf],
        slide: function( event, ui ) {
            render($("#colorcount"), 22, ui.values[0], ui.values[1], "");
        }
    });
    render($("#colorcount"), 22, bi, bf, "");

    $('#movescountslider').slider({
        min: 0,
        max: 205,
        range: true,
        values: [ci, cf],
        step: 5,
        slide: function( event, ui ) {
            render($("#movescount"), 200, ui.values[0], ui.values[1], "");
        }
    });
    render($("#movescount"), 200, ci, cf, "");

    $('#timetakenslider').slider({
        min: 0,
        max: 30,
        range: true,
        values: [di, df],
        slide: function( event, ui ) {
            render($("#timetaken"), 30, ui.values[0], ui.values[1], " minutes");
        }
    });
    render($("#timetaken"), 30, di, df, " minutes");
    
    $("#refresh").click(function() {
        var url = '/gallery';
        url += '?completed=' + $('#completeslider').slider('values', 0) + "-" + $('#completeslider').slider('values', 1);
        url += '&numcolors=' + $('#colorcountslider').slider('values', 0) + "-" + $('#colorcountslider').slider('values', 1);
        url += '&nummoves=' + $('#movescountslider').slider('values', 0) + "-" + $('#movescountslider').slider('values', 1);
        if ($('#movescountslider').slider('values', 1) > 200) {
            url += '+';
        }
        url += '&time_taken=' + $('#timetakenslider').slider('values', 0) + "-" + $('#timetakenslider').slider('values', 1);
        window.location.href = url;
    });
});