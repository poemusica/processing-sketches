// Globals

boolean FLOCKING = true;
boolean TRAIL = false;
boolean ATTRACT = false;
boolean REPEL = false;

Button flockButton = new Button( new PVector( 10 , height + 5 ), 105, 35, "Toggle Flocking");
Button trailButton = new Button( new PVector( 120, height + 5 ), 105, 35, "Toggle Trails" );
Button attractButton = new Button( new PVector( 230, height + 5 ), 105, 35, "Toggle Attract" );
Button repelButton = new Button( new PVector( 340, height + 5 ), 105, 35, "Toggle Repel" );

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
  
  void swapColor()
  {
    color f = cfill;
    cfill = cstroke;
    cstroke = f;
  }
}


// Mouse clicks
void mouseClicked( MouseEvent e )
{
  if ( flockButton.contains( e.getX(), e.getY() ) )
  {  
    flockClick();
  }
  
  if ( trailButton.contains( e.getX(), e.getY() ) )
  {
    trailClick();
  }
  
  if ( attractButton.contains( e.getX(), e.getY() ) )
  {
    attractClick();
  }
  
  if ( repelButton.contains( e.getX(), e.getY() ) )
  {
    repelClick();
  }
  
}

// Javascript Helpers (must be top-level functions)
void flockClick()
{
  FLOCKING = !FLOCKING;
  flockButton.swapColor();
}

void trailClick()
{
  TRAIL = !TRAIL;
  trailButton.swapColor();
}

void attractClick()
{
  ATTRACT = !ATTRACT;
  if ( REPEL ) { REPEL = false; repelButton.swapColor(); }
  attractButton.swapColor();
}

void repelClick()
{
  REPEL = !REPEL;
  if ( ATTRACT ) { ATTRACT = false; attractButton.swapColor(); }
  repelButton.swapColor();
}
