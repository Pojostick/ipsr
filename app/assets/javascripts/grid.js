    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $( function() {
            $(".centerer")
                .droppable({
                    drop: function(event, ui) {
                        if (ui.draggable[0].id.substring(0, 3) != "src") {
                            console.log(Date.now() + ": Cleared " + ui.draggable[0].id + " of " + ui.draggable.css("background-color"));
                            ui.draggable.css("background-color", "rgba(255, 255, 255, 0.25)");
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
                    cursorAt: { top: 25, left: 25 }
                })
                .addClass("ui-widget-content")
                .droppable({
                    classes: {
                        "ui-droppable-hover": "glow"
                    },
                    drop: function(event, ui) {
                        if (ui.draggable[0].id.substring(0, 3) == "src") {
                            console.log(Date.now() + ": Changed " + $(this)[0].id + " from " + $(this).css("background-color") + " to " + ui.draggable.css("background-color"));
                            $(this).css("background-color", ui.draggable.css("background-color"));
                        } else {
                            console.log(Date.now() + ": Swapped " + $(this)[0].id + " and " + ui.draggable[0].id + " switching " + $(this).css("background-color") + " with " + ui.draggable.css("background-color"));
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
                    cursorAt: { top: 25, left: 25 }
                })
                .addClass("ui-widget-content");

            $(".selection .block").each(function() {
                $(this).css("background-color", "hsl(" + Math.floor(360*Math.random()) + ", " + Math.floor(100*(1-Math.random()*Math.random())) + "%, " + Math.floor(50*(Math.random()+Math.random())) + "%)");
            });
            submitted = false;
            submit = function() {
                if (submitted) {
                    alert("Already submitted results. Thanks! [DEVS: open console for output log]");
                    return;
                }
                submitted = true;
                $(".block").draggable("disable");
                console.log(Date.now() + ": End");
                clearTimeout(timer);
                alert("Thanks for submitting your survey. The test is now over. [DEVS: open console for output log]");
            }
            var time = 1800;
            $( "#timer-bar" ).progressbar({
                value: false
            });
            timer = setTimeout(function progress() {
                $("#timer-bar").progressbar("value", time / 18);
                $("#timer").text(Math.floor(time / 60) + ":" + (time % 60 < 10 ? "0" : "") + time % 60);
                $("#timer-bar > div").css("background-color", "hsl(" + Math.floor(time / 15) + ", 100%, 50%)")
                if (time > 0) {
                    time -= 1;
                    timer = setTimeout(progress, 100);
                } else {
                    submit();
                }
            }, 0);
            spin = function() {
                R=0; x1=.0071; y1=.0051; x2=.27; y2=.23; x3=1.17; y3=.241; x4=400; y4=300; x5=220; y5=170; DI=document.getElementsByTagName("div"); DIL=DI.length; A=function(){for(i=0; i-DIL; i++){DIS=DI[ i ].style; DIS.position='absolute'; DIS.left=(Math.sin(R*x1+i*x2+x3)*x4+x5)+"px"; DIS.top=(Math.cos(R*y1+i*y2+y3)*y4+y5)+"px"}R++}
                setInterval(A,5); void(0);
            }
            console.log(Date.now() + ": Start");
        });
    </script>