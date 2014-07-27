// PROGRAM GLOBALS //
Flock aflock;
ControlPanel controls;
FlowField perlinFlow;

// Bind Javascript
interface Javascript {}
Javascript javascript = null;
void bindJavascript( Javascript js ) { javascript = js; }

static int offset;
public int r0;
public int g0;
public int b0;

public color theme1;
public color theme2;

public color theme;
public color bgc;
public Texture bgTexture;


// MAIN SETUP AND DRAW //

// setup processing canvas
void setup()
{
  size( 800, 500 );
  smooth();
  frameRate( 30 );
    
  // for perlinColor
  offset = 75;
  r0 = int( random( offset, 255 - offset ) );
  g0 = int( random( offset, 255 - offset ) );
  b0 = int( random( offset, 255 - offset ) );

  // for lerpPerlinColor
  theme1 = randomColor();
  theme2 = randomColor();
  
  
  theme = lerpColor( theme1, theme2, 0.5 );
  bgc = color( 255 - red( theme ), 255 - green( theme ), 255 - blue( theme ), 255 ); 

  // background texture
  bgTexture = new Texture( bgc );

  
  // make creatures
  aflock = new Flock( 80 );
  
  // make buttons
  controls = new ControlPanel();
  
  // make vector field
  perlinFlow = new FlowField( 25 );
}

// main draw loop
void draw()
{
  // benchmark
  //println( frameRate );
  
  // draw background
  bgTexture.draw();
  
  // Draw flow field vectors to off-screen buffer
  if ( controls.buttons[(int)controls.buttonsIndex.get("flow")].state )
  { 
    perlinFlow.update();
    perlinFlow.draw();
  }
    
  // If javascript is not bound, draw buttons in processing.
  // Provides one second delay for binding.
  if ( javascript == null && frameCount > 30 )
  {
    controls.update();
    controls.draw();
  }
  
  aflock.draw();

}


// MOUSE EVENTS //
void mouseClicked( MouseEvent e )
{
  if ( javascript != null ) { return; }
  for (Button b : controls.buttons)
  {
    if ( b.contains(e.getX(), e.getY()) )
    { handleClick(b.label); } 
  }
}


// COLOR UTILITIES //


color randomColor() 
{
  return color( random(255), random(255), random(255) );
}


color lerpPerlinColor( float n )
{
  float amt = noise( 1, n );
  return lerpColor( theme1, theme2, amt );
}


color perlinColor( int n )
{
  float rval = noise( 1, n );
  int r1 = int( map( rval, 0, 1, -offset, offset ) );
  float gval = noise( 2, n );
  int g1 = int( map( gval, 0, 1, -offset, offset ) );
  float bval = noise( 3, n );
  int b1 = int( map( bval, 0, 1, -offset, offset ) );
  color c = color( r0 + r1, g0 + g1, b0 + b1, 220 );
  return c;
}
