
// GLOBAL VARIABLES //

Blob[] blobs = new Blob[ 20 ];
Button toggle = new Button();

// MAIN SETUP AND DRAWING //

// Setup the Processing Canvas
void setup()
{
  size( 500, 500 );
  smooth();
  frameRate( 30 );
  
  for ( int i = 0; i < 20; i++ ) 
  {
    float x = random( width );
    float y = random( height );
    Blob b = new Blob( x, y );
    blobs[ i ] = b;
  }

}

// Main draw loop
void draw()
{
  background(0xFF33FFCC);
  
  for ( int i = 0; i < blobs.length; i++ )
  {
    Blob b = blobs[ i ];
    b.update();
    b.draw();
  }
  
  toggle.draw();

}

// UTILITIES //

// Make a random color.
color random_color() 
{
  return color( random(255), random(255), random(255), 220 );
}

// CLASSES //

// Defines Toggle button
class Button
{
  color cstroke, cfill;
  String toggle_text = "Toggle flocking";
  
  Button ()
  {
    cstroke = random_color();
    cfill = random_color();
  }
  
  void draw( ) 
  {
    strokeWeight( 3 );
    stroke( cstroke );
    fill( cfill );
    rect( 25, 430, 100, 45, 10 );
    textSize( 12 );
    fill( 0,0,0 );
    text( toggle_text, 30, 458 );
  }
  
}

// Defines Blob class
class Blob
{
  float x, y, speed, angle;
  color cstroke, cfill;
  
  Blob ( float posx, float posy ) 
  {
    x = posx;
    y = posy;
    speed = 1.275;
    angle = radians( random( 359 ) );
    cstroke = random_color();
    cfill = random_color();
  }
  
  float[] separate( int x, int y )
  {
    float ideal = 2.0;
    float dx = 0;
    float dy = 0;
    float[] offset = { dx, dy };
    
    for ( int i = 0; i < blobs.length; i++ ) {
      Blob b = blobs[ i ];
      // if b != me: do stuff;
    
    }; 
    
    return offset;
  }
  
  void update()
  {
    float dx = cos( angle ) * speed;
    float dy = sin( angle ) * speed;
    x += dx;
    y += dy;
    
    if ( x < 0 )
    {
      x = width;
    } else if ( x > width )
    {
      x = 0;
    }
    
    if ( y < 0 )
    {
      y = height;
    } else if ( y > height )
    {
      y = 0;
    }
  }
  
  void draw()
  {
    strokeWeight( 2 );
    stroke( cstroke );
    fill( cfill );
    ellipse( x, y, 8, 8 );
    //float x1 = x - 8;
    //float y1 = y - 8;
    //float y3 = y + 8;
    //triangle( x1, y1, x, y, x1, y3 );
  }
}
