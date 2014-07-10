// Create a processing sketch object
var sketch = new Processing.Sketch();

sketch.attachFunction = function(processing) {
// Global sketch variables
    var blobs = [];

// Coin flip
function coin_flip(){
    result = Math.floor(Math.random() * 2);
    return result;
}


// Definition of Blob object
    function Blob(posX, posY) {
        this.x = posX;
        this.y = posY;
        this.s = -1.275;

        this.update = function(){
            this.x += this.s;
            this.y += this.s;

            if (this.x < 0 || this.x > processing.width) {
                this.x = Math.abs(this.x) % processing.width;
            }

            if (this.y > processing.height){
                this.y = Math.abs(this.y) % processing.height;
            }

        };

        this.draw = function(){
            processing.strokeWeight(3);
            processing.stroke(0xFFFF3300);
            processing.fill(0xFFFF5050);
            processing.ellipse(this.x, this.y, 10, 10);
        };
    }


// Populates blobs array.
    function make_blobs(num){
        for (var i = 0; i < num; i++){
            var x = Math.random() * 500;
            var y = Math.random() * 500;
            var b = new Blob(x, y);
            blobs.push(b);
        }
    }

// Setup function
    processing.setup = function() {
        // Set size of canvas
        // MUST BE FIRST LINE OF SETUP FUNCTION!!
        processing.size(500, 500);
        processing.frameRate(30);

        // Populate blobs array.
        make_blobs(10);
    };

// Draw function
    processing.draw = function() {

        processing.background(0xFF33FFCC);

        for (var i = 0; i < blobs.length; i++) {
            var b = blobs[i];
            b.update();
            b.draw();
        }
    };
};

// Attach sketch to canvas
var canvas = document.getElementById("mycanv");
var p = new Processing(canvas, sketch);