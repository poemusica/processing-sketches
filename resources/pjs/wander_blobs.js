
// Coin flip
function coin_flip(){
    result = Math.floor(Math.random() * 2);
    return result;
}

// Definition of Blob object
function Blob(posX, posY, processing){
    this.x = posX;
    this.y = posY;
    this.processing = processing;
    this.r = Math.random() * 2 * Math.PI;
    this.s = Math.random() * 2;
}

Blob.prototype.update = function(){
    this.x += this.s;
    this.y += this.s;

    if(this.x < 0) {
        this.x = this.processing.width;
    } else if (this.x > this.processing.width) {
        this.x = 0;
    }

    if(this.y < 0) {
        this.y = this.processing.height;
    } else if (this.y > this.processing.height){
        this.y = 0;
    }

};

Blob.prototype.draw = function(){
    this.processing.strokeWeight(3);
    this.processing.stroke(0xFFFF3300);
    this.processing.fill(0xFFFF5050);
    this.processing.ellipse(this.x, this.y, 10, 10);
};

// Create a processing sketch object
var sketch = new Processing.Sketch();

sketch.attachFunction = function(processing){
    // Global sketch variables
    var blobs = [];

    // Setup function
    processing.setup = function(){
        // Set size of canvas
        // MUST BE FIRST LINE OF SETUP FUNCTION!!
        processing.size(500, 500);
        processing.frameRate(30);

        // Populate blobs array.
        for (var i = 0; i < 20; i++){
            var x = Math.random() * 500;
            var y = Math.random() * 500;
            var b = new Blob(x, y, processing);
            blobs.push(b);
        }
    };

    // Draw function
    processing.draw = function() {
        processing.background(0xFF33FFCC);

        for (var i = 0; i < blobs.length; i++){
            var b = blobs[i];
            b.update();
            b.draw();
        }
    };
};

// Attach sketch to canvas
var canvas = document.getElementById("mycanv");
var p = new Processing(canvas, sketch);