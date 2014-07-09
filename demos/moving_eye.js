
// Attaching js code to the canvas by using a sketch object
var sketch = new Processing.Sketch();

// attach function (also, can be specified as the single parameter 
// in the Processing.Sketch object constructor)
sketch.attachFunction = function(processing) {
    var radius = 50.0;
    var delay = 16;
    var X, Y, nX, nY;

    processing.setup = function() {
        processing.size(200, 200);
        processing.strokeWeight(10);
        processing.frameRate(15);
        X = processing.width / 2;
        Y = processing.height / 2;
        nX = X;
        nY = Y;
    };
    
    processing.draw = function() {
        radius = radius + Math.sin(processing.frameCount / 4);

        // Track circle to new destination
        X += (nX - X) / delay;
        Y += (nY - Y) / delay;

        // Fill canvas grey
        processing.background(100);

        // Set fill-color to blue
        processing.fill(0, 121, 184);

        // Set stroke-color white
        processing.stroke(255);

        // Draw circle
        processing.ellipse(X, Y, radius, radius);
    };

    processing.mouseMoved = function() {
        nX = processing.mouseX;
        nY = processing.mouseY;
    };

};

var canvas = document.getElementById("mycanv");
// attaching the sketch to the canvas
var p = new Processing(canvas, sketch);