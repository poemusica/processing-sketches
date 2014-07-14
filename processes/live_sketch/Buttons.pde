// Globals

boolean FLOCKING = true;
boolean TRAIL = false;

Button flockButton = new Button( new PVector( 30, 445 ), 105, 35, "Toggle Flocking");
Button trailButton = new Button( new PVector( 165, 445), 105, 35, "Toggle Trails" );

// Javascript Helpers
void flockClick()
{
  FLOCKING = !FLOCKING;
  color f = flockButton.cfill;
  flockButton.cfill = flockButton.cstroke;
  flockButton.cstroke = f;
}

void trailClick()
{
  TRAIL = !TRAIL;
  color f = trailButton.cfill;
  trailButton.cfill = trailButton.cstroke;
  trailButton.cstroke = f;
}


// Defines Button class
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
    
    cstroke = randomColor();
    cfill = randomColor();
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
