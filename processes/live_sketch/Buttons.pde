// Globals

Button flockButton = new Button( new PVector( 10 , height + 5 ), 50, 35, "Flock", true );
Button trailButton = new Button( new PVector( 70, height + 5 ), 50, 35, "Trails", false );
Button attractButton = new Button( new PVector( 130, height + 5 ), 50, 35, "Attract", false );
Button repelButton = new Button( new PVector( 190, height + 5 ), 50, 35, "Repel", false );
Button wallButton = new Button( new PVector( 250, height + 5 ), 50, 35, "Walls", false );


// Defines Button class
class Button
{
  float bwidth, bheight;
  PVector pos;
  color cstroke, cfill;
  String label;
  boolean state;
  
  Button ( PVector p, float w, float h, String l, boolean s)
  {
    bwidth = w;
    bheight = h;
    pos = p;
    label = l;
    state = s;
    cstroke = randomColor();
    cfill = randomColor();
  }
  
  boolean contains( int x, int y )
  { return pos.x < x && x < pos.x + bwidth && pos.y < y && y < pos.y + bheight; }
  
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
  {  flockClick(); }
  
  if ( trailButton.contains( e.getX(), e.getY() ) )
  { trailClick(); }
  
  if ( attractButton.contains( e.getX(), e.getY() ) )
  { attractClick(); }
  
  if ( repelButton.contains( e.getX(), e.getY() ) )
  { repelClick(); }
  
  if ( wallButton.contains( e.getX(), e.getY() ) )
  { wallClick(); }
}

// Javascript Helpers (must be top-level functions)
void flockClick()
{
  flockButton.state = !flockButton.state;
  flockButton.swapColor();
}

void trailClick()
{
  trailButton.state = !trailButton.state;
  trailButton.swapColor();
}

void attractClick()
{
  attractButton.state = !attractButton.state;
  if ( repelButton.state ) { repelButton.state = false; repelButton.swapColor(); }
  attractButton.swapColor();
}

void repelClick()
{
  repelButton.state = !repelButton.state;
  if ( attractButton.state ) { attractButton.state = false; attractButton.swapColor(); }
  repelButton.swapColor();
}

void wallClick()
{
  wallButton.state = !wallButton.state;
  wallButton.swapColor();
}
