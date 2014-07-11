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
    float x, y, speed, angle;
    color cfill, cstroke;
    Blob ( float posx, float posy ) {
        x = posx;
        y = posy;
        speed = 1.275;
        angle = radians( random( 359 ) );
        cfill = color( random(255), random(255), random(255), random(255) );
        noStroke();
        //cstroke = color( random(255), random(255), random(255), random(255) );
    }
    
    void update() {
        dx = cos(angle) * speed;
        dy = sin(angle) * speed;
        x += dx;
        y += dy;
      
        if ( x < 0 ) {
          x = width;
        } else if ( x > width ) {
          x = 0;
        } if ( y < 0 ) {
          y = height;
        } else if ( y > height ) {
          y = 0;
        }
    
    }
    
    void draw() {              
        strokeWeight( 3 );
        //stroke( cstroke );
        fill( cfill );
        ellipse( x, y, 8, 8 );
        //float x1 = x - 8;
        //float y1 = y - 8;
        //float y3 = y + 8;
        //triangle(x1, y1, x, y, x1, y3);
    }
}
