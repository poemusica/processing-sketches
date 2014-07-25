// Global variables
Blob[] blobs = new Blob[ 20 ];

// Setup the Processing Canvas
void setup() {
    size( 500, 500 );
    smooth();
    frameRate( 30 );

    for ( int i = 0; i < 20; i++ ) {
        float x = random(500);
        float y = random(500);
        Blob b = new Blob( x, y );
        blobs[i] = b;
    }
}

// Main draw loop
void draw() {
    background(0xFF33FFCC);

    for ( int i = 0; i < blobs.length; i++ ) {
        Blob b = blobs[i];
        b.update();
        b.draw();
    }

}

// Defines Blob class
class Blob {
    float x, y, s;
    Blob ( float posx, float posy ) {
        x = posx;
        y = posy;
        s = 1.275;
    }
    
    void update() {
      
        x += s;
        y += s;
        
        if ( x < 0 ) {
          x = width;
        } else if ( x > width ) {
          x = 0;
        }
        
        if ( y < 0 ) {
          y = height;
        } else if ( y > height ) {
          y = 0;
        }
    
    }
    
    void draw() {              
        strokeWeight( 3 );
        stroke( 0xFFFF3300 );
        fill( 0xFFFF5050 );
        ellipse( x, y, 8, 8 );
    }
}