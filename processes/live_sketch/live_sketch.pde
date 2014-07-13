
// GLOBAL VARIABLES //

Blob[] blobs = new Blob[ 40 ];
Button flock_button = new Button( new PVector( 30, 445 ), 105, 35, "Toggle Flocking");
Button trails_button = new Button( new PVector( 165, 445), 105, 35, "Toggle Trails" );

boolean FLOCKING = true;
boolean TRAILS = false;

// MAIN SETUP AND DRAWING //

// Setup the Processing Canvas
void setup()
{
  size( 500, 500 );
  smooth();
  frameRate( 30 );
  
  for ( int i = 0; i < blobs.length; i++ ) 
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
  if ( !TRAILS )
  { 
    background( 0xFF33FFCC ); 
  }
  
  for ( int i = 0; i < blobs.length; i++ )
  {
    Blob b = blobs[ i ];
    b.update();
    b.draw();
  }
  
  flock_button.draw();
  trails_button.draw();

}

// Mouse 
void mouseClicked( MouseEvent e )
{
  if ( flock_button.contains( e.getX(), e.getY() ) )
  {
    FLOCKING = !FLOCKING;
    color f = flock_button.cfill;
    flock_button.cfill = flock_button.cstroke;
    flock_button.cstroke = f;
  }
  
  if ( trails_button.contains( e.getX(), e.getY() ) )
  {
    TRAILS = !TRAILS;
    color f = trails_button.cfill;
    trails_button.cfill = trails_button.cstroke;
    trails_button.cstroke = f;
  }
  
  
}


// UTILITIES //

// Make a random color.
color random_color() 
{
  return color( random(255), random(255), random(255), 220 );
}

float angle_change()
{
  float limit = radians( 15 );
  float magic = random( -limit, limit );
  return magic;
}

// CLASSES //

// Defines Toggle button
class Button
{
  float bwidth, bheight;
  PVector pos;
  color cstroke, cfill;
  String label;
  
  Button ( PVector p, float w, float h, String s )
  {
    bwidth = w;
    bheight = h;
    pos = p;
    label = s;
    
    cstroke = random_color();
    cfill = random_color();
  }
  
  boolean contains( int x, int y )
  {
    return pos.x < x && x < pos.x + bwidth && pos.y < y && y < pos.y + bheight;
  }
  
  void draw( ) 
  {
    strokeWeight( 3 );
    stroke( cstroke );
    fill( cfill );
    rect( pos.x, pos.y, bwidth, bheight, 10 );
    textSize( 12 );
    fill( 0,0,0 );
    text( label, pos.x + 5, pos.y + bheight/2 + 4 );
  }
  
}
