// MAIN SETUP AND DRAWING //

// Bind Javascript
interface Javascript {}
Javascript javascript = null;
void bindJavascript( Javascript js ) { javascript = js; }

// Setup the Processing Canvas
void setup()
{
  size( 800, 500, P2D );
  smooth();
  frameRate( 60 );
  
  // make blobs
  for ( int i = 0; i < blobs.length; i++ ) 
  {
    float x = random( width );
    float y = random( height );
    Blob b = new Blob( x, y );
    blobs[ i ] = b;
  }
  
  // make vector field
  perlinFlow.init();
 
}

// Main draw loop
void draw()
{
  // benchmark
  println( frameRate );
  
  if ( !trailButton.state ) { background( 0xFF33FFCC ); }
  
  // Draw flow field vectors
  if ( flowButton.state )
  { 
    perlinFlow.update();
    //perlinFlow.draw(); 
  }
    
  // If javascript is not bound, draw buttons in processing.
  // Provides one second delay for binding.
  if ( javascript == null && frameCount > 30 )
  {
    flockButton.draw();
    trailButton.draw();
    attractButton.draw();
    repelButton.draw();
    wallButton.draw();
    flowButton.draw();
  }
       
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
