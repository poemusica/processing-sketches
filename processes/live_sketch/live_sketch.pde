// MAIN SETUP AND DRAWING //

// Bind Javascript
interface Javascript {}
Javascript javascript = null;
void bindJavascript( Javascript js ) { javascript = js; }

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
  if ( !TRAIL )
  { 
    background( 0xFF33FFCC ); 
  }
  
  for ( int i = 0; i < blobs.length; i++ )
  {
    Blob b = blobs[ i ];
    b.update();
    b.draw();
  }
  
  // If javascript is not bound, draw buttons in processing.
  // Provides one second delay for binding.
  if ( javascript == null && frameCount > 30 )
  {
    flockButton.draw();
    trailButton.draw();
  }

}

// Mouse 
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
  
  
}


// UTILITIES //

// Make a random color.
color randomColor() 
{
  return color( random(255), random(255), random(255), 220 );
}

float angleChange()
{
  float limit = radians( 15 );
  float magic = random( -limit, limit );
  return magic;
}
