// MAIN SETUP AND DRAWING //

// Bind Javascript
interface Javascript {}
Javascript javascript = null;
void bindJavascript( Javascript js ) { javascript = js; }

// Setup the Processing Canvas
void setup()
{
  size( 800, 500 );
  smooth();
  frameRate( 30 );
  
  // make blobs
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
  if ( !trailButton.state ) { background( 0xFF33FFCC ); }
    
  // If javascript is not bound, draw buttons in processing.
  // Provides one second delay for binding.
  if ( javascript == null && frameCount > 30 )
  {
    flockButton.draw();
    trailButton.draw();
    attractButton.draw();
    repelButton.draw();
    wallButton.draw();
  }
  
  randomFlow.draw();
  
  for ( Blob b : blobs )
  {
    b.update();
    b.draw();
  }

}

// UTILITIES //

// Make a random color.
color randomColor() 
{
  return color( random(255), random(255), random(255), 220 );
}
