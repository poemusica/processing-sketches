// Attaching js code to the canvas by using a sketch object
var sketch = new Processing.Sketch();

sketch.attachFunction = function(processing) {
// Global variables go here
    var blobs = [];


// Definition of Blob object
    function Blob(posX, posY) {
        this.x = posX;
        this.y = posY;

        processing.strokeWeight(3);
        processing.stroke(0xFFFF3300);
        processing.fill(0xFFFF5050);

        this.draw = function(){
            processing.ellipse(this.x, this.y, 15, 15);
        };
    }

    function make_blobs(num){
        for (var i = 0; i < num; i++){
            var x = Math.floor( (Math.random() * 500) + 1 );
            var y = Math.floor( (Math.random() * 500) + 1 );
            var b = new Blob(x, y);
            blobs.push(b);
        }
    }

// Setup function
    processing.setup = function() {
        // Set size of canvas
        // MUST BE FIRST LINE OF SETUP FUNCTION!!
        processing.size(500, 500);
        processing.frameRate(15);

        // Make array of blobs
        make_blobs(10);
    };

// Draw function
    processing.draw = function() {

        processing.background(0xFF33FFCC);

        for (var i = 0; i < blobs.length; i++) {
            var b = blobs[i];
            b.x += 1;
            b.y += 1;
            if (b.x < 0 || b.x > processing.width) {
                b.x = Math.abs(b.x) % processing.width;
            }
            if (b.y > processing.height){
                b.y = Math.abs(b.y) % processing.height;
            }
            blobs[i].draw();
        }
    };
};

var canvas = document.getElementById("mycanv");
var p = new Processing(canvas, sketch);