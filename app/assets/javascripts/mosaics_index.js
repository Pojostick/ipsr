$( function() {
    submitbutton = $("#submitbutton").detach();
    submitbutton.appendTo($("#menubar"));
    
    function byteToHex(c) {
        var hex = parseInt(c).toString(16);
        return hex.length == 1 ? "0" + hex : hex;
    }
    function rgbToHex(rgb) {
        rgb = rgb.split(/[^\d]+/).slice(1, 4);
        return "#" + byteToHex(rgb[0]) + byteToHex(rgb[1]) + byteToHex(rgb[2]);
    }
    var id = $("#APPDATA").attr("mosaic_id");
    var indexData = 0;
    autosave = function(tileFromData, tileToData, colorData) {
        if (tileFromData == tileToData) return;
        colorData.replace(" ", "");
        if (colorData.substring(0, 4) == "rgba") {
            colorData = "transparent"
        }
        if (colorData.substring(0, 3) == "rgb") {
            colorData = rgbToHex(colorData);
        }
        console.log(time);
        $.ajax({
            type: "POST",
            url: "/mosaics/autosave",
            data: { mosaic_id: id,
                    index: indexData++,
                    tileFrom: tileFromData,
                    tileTo: tileToData,
                    color:  colorData,
                    time_left: time,
            }
        });
    }
    $(".centerer")
        .droppable({
            drop: function(event, ui) {
                if (ui.draggable[0].id.substring(0, 3) != "src") {
                    console.log(indexData + ": Cleared " + ui.draggable[0].id + " of " + ui.draggable.css("background-color"));
                    ui.draggable.css("background-color", "");
                    autosave(ui.draggable[0].id, -1, "transparent");
                }
            }
        });
    $(".mosaic table")
        .droppable({
            greedy: true
        });
    $(".mosaic .block")
        .draggable({
            helper: "clone",
            cursor: "move",
            cursorAt: { top: 25, left: 25 },
            opacity: 0.75
        })
        .addClass("ui-widget-content")
        .droppable({
            hoverClass: 'glow',
            drop: function(event, ui) {
                if (ui.draggable[0].id.substring(0, 3) == "src") {
                    console.log(indexData + ": Changed " + $(this)[0].id + " from " + $(this).css("background-color") + " to " + ui.draggable.css("background-color"));
                    $(this).css("background-color", ui.draggable.css("background-color"));
                    autosave(-1, $(this)[0].id, ui.draggable.css("background-color"));
                } else {
                    console.log(indexData + ": Swapped " + $(this)[0].id + " and " + ui.draggable[0].id + " switching " + $(this).css("background-color") + " with " + ui.draggable.css("background-color"));
                    autosave(ui.draggable[0].id, $(this)[0].id, ui.draggable.css("background-color"));
                    // autosave($(this)[0].id, ui.draggable[0].id, $(this).css("background-color"));
                    // temp = $(this).css("background-color");
                    $(this).css("background-color", ui.draggable.css("background-color"));
                    // ui.draggable.css("background-color", temp);
                    ui.draggable.css("background-color", "");
                }
            },
            greedy: true,
            tolerance: "pointer"
        });
    $(".selection .block")
        .draggable({
            helper: "clone",
            cursor: "move",
            cursorAt: { top: 25, left: 25 },
            opacity: 0.75
        })
        .addClass("ui-widget-content");

    submit = function(timeout) {
        if (time == -1) return;
        $.ajax({
            type: "POST",
            url: "/mosaics/autosave",
            data: { time_taken: TIME - time }
        });
        time = -1;
        $(".block").draggable("disable");
        $("#timer").css("cursor", "wait");
        $("#timer").text("Submitting test...");
        $("#timer-bar").progressbar("value", 100);
        $("#timer-bar > div").css("background-color", "#fb8");
        hide_time = show_time = function() {};
        clearTimeout(timer);
        alert((timeout ? "Time's up. Thanks for completing" : "Thanks for submitting") + " your mosaic!");
        window.location.href = "/mosaics/" + id;
    }
    
    var TIME = 60 * parseInt($("#APPDATA").attr("time_total"));
    var total = parseInt($("#APPDATA").attr("time_left"));
    var time = total;
    var start = Date.now();
    
    hide_time = function() {
        $("#timer").text("Submit");
        $("#timer-bar").progressbar("value", 100);
    };
    
    show_time = function() {
        $("#timer").text(Math.floor(time / 60) + ":" + (time % 60 < 10 ? "0" : "") + time % 60);
        $("#timer-bar").progressbar("value", time / (TIME / 100));
    };
    
    var update = hide_time;
    
    $("#timer-bar").progressbar();
    $("#timer-bar").hover(function() {update = show_time; update()},
                          function() {update = hide_time; update()});
    timer = setTimeout(function progress() {
        if (time > 0) {
            time = total - Math.floor((Date.now() - start) / 1000);
            timer = setTimeout(progress, 1000);
            update();
        } else if (total > 0) {
            submit(true);
        }
    }, 0);
});
