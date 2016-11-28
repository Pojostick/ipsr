$( function() {
    // USE AJAX API GET CALL
    // DELETE IF NOT GOING TO BE USED (need to make route to work)
    $.ajax({
        type: "GET",
        url: "/mosaics/1",
    }).done(function( data ) {
        console.log( "Sample of data:", data.slice( 0, 100 ) );
    });

    // HACKY BYPASS
    var steps = $("#APPDATA").attr("steps");
    
    /** Initialize Variables */
    var COLOR = ['#0173b5', '#edbd10', '#995159', '#f7bb62', '#4c306d', '#9b0a2f', '#413096', '#93d6a7', '#8c6248', '#d65a31', '#ffffff', '#0a0a0a', '#560636', '#9bbddb', '#f4ed90', '#380d09', '#8e8e99', "#c17d58", '#2b6855', '#f7d9e3', '#b57dc6', '#173f37'];
    var grid = [];
    var tiles = [];
    var ID = 0;
    var SIZE = 60;
    var STEPS = 250;
    var WIDTH = 10;
    var HEIGHT = 8;
    var DASHES = [];
    var canvas = document.getElementById("display");
    var ctx = canvas.getContext("2d");
    canvas.width = WIDTH * SIZE;
    canvas.height = HEIGHT * SIZE;

    var stepRecord = [];
    var current = -1;
    
    var Tile = function(color, x, y, z) {
        this.id = ++ID;
        tiles[this.id] = this;
        this.x = x;
        this.y = y;
        this.z = z;
        this.color = color;
        this.animation = false;
        this.draw = function(ctx) {
            if (this.z <= 0.01) return;
            if (this.z >= 0.99) this.z = 1;
            var x = Math.round(SIZE * this.x);
            var y = Math.round(SIZE * this.y);
            ctx.globalAlpha = this.z;
            ctx.setLineDash([]);
            ctx.strokeStyle = '#fff';
            ctx.lineWidth = 0.5;
            ctx.strokeRect(x, y, SIZE, SIZE);
            ctx.fillStyle = this.color;
            ctx.fillRect(x, y, SIZE, SIZE);
            ctx.globalAlpha = 1;
        };
    };
    
    var Step = function(tile, ax, ay, az, bx, by, bz) {
        this.id = undefined;
        this.tile = tile;
        this.ax = ax;
        this.ay = ay;
        this.az = az;
        this.bx = bx;
        this.by = by;
        this.bz = bz;
        this.progress = 0;
        this.do = function() {
            var success = true;
            if (this.progress < 0 || this.progress > 1) success = false;
            if (this.progress < 0) this.progress = 0;
            if (this.progress > 1) this.progress = 1;
            this.tile.x = this.ax + (this.bx - this.ax) * this.progress;
            this.tile.y = this.ay + (this.by - this.ay) * this.progress;
            this.tile.z = this.az + (this.bz - this.az) * this.progress;
            return success;
        };
    };
    
    var redo = function(instant) {
        if (current < stepRecord.length - 1) {
            current++;
            var records = stepRecord[current];
            for (var key in records) {
                var record = records[key];
                record.progress = 0;
                if (record.tile.animation) {
                    var steps = stepRecord[record.tile.animation];
                    for (var key2 in steps) {
                        var step = steps[key2];
                        clearTimeout(step.id);
                        step.progress = 1;
                        step.do();
                    }
                    record.tile.animation = false;
                }
                if (instant) {
                    record.progress = 1;
                    record.do();
                } else {
                    var repeat = 0;
                    var speed = Math.abs(record.ax - record.bx) + Math.abs(record.ay - record.by);
                    speed = 0.25 - 0.2 * Math.min(speed / 10, 1);
                    var interpolate = function() {
                        repeat++;
                        record.progress += speed;
                        if (record.do() && repeat < 20) {
                            record.id = setTimeout(interpolate, 25);
                        } else {
                            record.tile.animation = false;
                        }
                    };
                    record.tile.animation = current;
                    record.id = setTimeout(interpolate, 25);
                }
            }
            return true;
        }
        return false;
    };
    
    var undo = function(instant) {
        if (current >= 0) {
            var records = stepRecord[current];
            for (var key in records) {
                var record = records[key];
                record.progress = 1;
                if (record.tile.animation) {
                    var steps = stepRecord[record.tile.animation];
                    for (var key2 in steps) {
                        var step = steps[key2];
                        clearTimeout(step.id);
                        step.progress = 0;
                        step.do();
                    }
                    record.tile.animation = false;
                }
                if (instant) {
                    record.progress = 0;
                    record.do();
                } else {
                    var repeat = 0;
                    var speed = Math.abs(record.ax - record.bx) + Math.abs(record.ay - record.by);
                    speed = 0.25 - 0.2 * Math.min(speed / 10, 1);
                    var interpolate = function() {
                        repeat++;
                        record.progress -= speed;
                        if (record.do() && repeat < 20) {
                            record.id = setTimeout(interpolate, 25);
                        } else {
                            record.tile.animation = false;
                        }
                    };
                    record.tile.animation = current;
                    record.id = setTimeout(interpolate, 25);
                }
            }
            current--;
            return true;
        }
        return false;
    };
    
    steps = steps.split(',');
    for (var i = 0; i < steps.length; i++) {
        var step = steps[i].split(' ');
        if (step.length == 1) continue;
        var tileFrom = parseInt(step[0]);
        var tileTo = parseInt(step[1]);
        var xi = tileFrom % 10;
        var yi = Math.floor(tileFrom / 10);
        var xf = tileTo % 10;
        var yf = Math.floor(tileTo / 10);
        if (tileFrom == -1 && tileTo != -1) {
            var tile = new Tile(step[2], xf, yf, 0);
            grid[tileTo] = tile;
            stepRecord.push([new Step(tile, xf, yf, 0, xf, yf, 1)]);
        } else if (tileFrom != -1 && tileTo == -1) {
            var tile = grid[tileFrom];
            stepRecord.push([new Step(tile, xi, yi, 1, xi, yi, 0)]);
        } else if (tileFrom != -1 && tileTo != -1) {
            var tilei = grid[tileFrom];
            var tilef = grid[tileTo];
            grid[tileFrom] = tilef;
            grid[tileTo] = tilei;
            if (tilei && tilef) {
                stepRecord.push([new Step(tilei, xi, yi, 1, xf, yf, 1)], [new Step(tilef, xf, yf, 1, xi, yi, 1)]);
            } else if (tilei) {
                stepRecord.push([new Step(tilei, xi, yi, 1, xf, yf, 1)]);
            } else if (tilef) {
                stepRecord.push([new Step(tilef, xf, yf, 1, xi, yi, 1)]);
            }
        }
        redo(true);
    }
    console.log(stepRecord);
    STEPS = stepRecord.length;

    var handle = $('#handle');
    var slider = $('#slider');
    $('#slider').slider({
        min: 1,
        max: STEPS + 1
    });
        
    var diff = 0;
    var animate = function() {
        diff = $('#slider').slider('value')- 2 - current;
        if (diff < -10) { // skip for faster progress
            for (var i = 0; i < Math.abs(diff / 10); i++) {
                undo(true);
            }
        } else if (diff > 10) {
            for (var i = 0; i < Math.abs(diff / 10); i++) {
                redo(true);
            }
        }
        if (diff < 0) {
            undo();
        } else if (diff > 0) {
            redo();
        }
        handle.text((current + 2) + ' [' + slider.slider('value') + ']');
        setTimeout(animate, 100);
    };
    setTimeout(animate, 100);
    
    var render = function() {
        requestAnimationFrame(render);
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        var overlay = [];
        for (var key in tiles) {
            var tile = tiles[key];
            if (tile.animation) {
                overlay.push(tile);
            } else {
                tile.draw(ctx);
            }
        }
        for (var i = 0; i < overlay.length; i++) {
            var tile = overlay[i];
            tile.draw(ctx);
        }
    };
    
    render();
});
