$( function() {
    function byteToHex(c) {
        var hex = parseInt(c).toString(16);
        return hex.length == 1 ? "0" + hex : hex;
    }
    function rgbToHex(rgb) {
        rgb = rgb.split(/[^\d]+/).slice(1, 4);
        return "#" + byteToHex(rgb[0]) + byteToHex(rgb[1]) + byteToHex(rgb[2]);
    }
    var id = $("#APPDATA").attr("mosaic_id");
    autosave = function(timestamp, tileIdData, colorData) {
        colorData.replace(" ", "");
        if (colorData.substring(0, 4) == "rgba") {
            colorData = "transparent"
        }
        if (colorData.substring(0, 3) == "rgb") {
            colorData = rgbToHex(colorData);
        }
        $.ajax({
            type: "POST",
            url: "/mosaics/autosave",
            data: { mosaic_id: id,
                    time: timestamp,
                    tileId: tileIdData,
                    color:  colorData
            }
        });
    }
    $(".centerer")
        .droppable({
            drop: function(event, ui) {
                if (ui.draggable[0].id.substring(0, 3) != "src") {
                    console.log(Date.now() + ": Cleared " + ui.draggable[0].id + " of " + ui.draggable.css("background-color"));
                    ui.draggable.css("background-color", "");
                    autosave(Date.now(), ui.draggable[0].id, "transparent");
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
                    console.log(Date.now() + ": Changed " + $(this)[0].id + " from " + $(this).css("background-color") + " to " + ui.draggable.css("background-color"));
                    $(this).css("background-color", ui.draggable.css("background-color"));
                    autosave(Date.now(), $(this)[0].id, ui.draggable.css("background-color"));
                } else {
                    console.log(Date.now() + ": Swapped " + $(this)[0].id + " and " + ui.draggable[0].id + " switching " + $(this).css("background-color") + " with " + ui.draggable.css("background-color"));
                    autosave(Date.now(), $(this)[0].id, ui.draggable.css("background-color"));
                    autosave(Date.now(), ui.draggable[0].id, $(this).css("background-color"));
                    temp = $(this).css("background-color");
                    $(this).css("background-color", ui.draggable.css("background-color"));
                    ui.draggable.css("background-color", temp);
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

    submit = function() {
        $(".block").draggable("disable");
        console.log(Date.now() + ": End");
        clearTimeout(timer);
        alert("Thanks for submitting your survey. The test is now over. [DEVS: open console for output log]");
        $.ajax({type: "GET", url: "/mosaics/" + id});
    }
    var TIME = 300;
    var time = TIME;
    $( "#timer-bar" ).progressbar();
    timer = setTimeout(function progress() {
        $("#timer-bar").progressbar("value", time / (TIME / 100));
        $("#timer").text(Math.floor(time / 60) + ":" + (time % 60 < 10 ? "0" : "") + time % 60);
        $("#timer-bar > div").css("background-color", "hsl(" + Math.floor(time / (TIME * 5 / 600)) + ", 100%, 50%)")
        if (time > 0) {
            time -= 1;
            timer = setTimeout(progress, 1000);
        } else {
            submit();
        }
    }, 0);
    console.log(Date.now() + ": Start");
});
