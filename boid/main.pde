// PROGRAM GLOBALS //
Flock aflock;
ControlPanel controls;
FlowField perlinFlow;
Theme theme;
Texture bgTexture;  // this should eventually be a background art object.

// Bind Javascript
interface Javascript {}
Javascript javascript = null;
void bindJavascript( Javascript js ) { javascript = js; }


// MAIN SETUP AND DRAW //

void setup()
{
  size( 800, 500 );
  smooth();
  frameRate( 30 );
  
  theme = new Theme(); // make color scheme
  bgTexture = new Texture( theme.bgc ); // make background texture
  aflock = new Flock( 80 ); // make creatures
  controls = new ControlPanel(); // make native buttons
  perlinFlow = new FlowField( 25 ); // make vector field
}


void draw()
{
  bgTexture.draw();
  
  if ( controls.buttons[(int)controls.buttonsIndex.get("flow")].state )
  { perlinFlow.update(); perlinFlow.draw(); }
    
  if ( javascript == null && frameCount > 30 ) // display buttons in native mode  only
  { controls.update(); controls.draw(); }
  
  aflock.draw();
  
  //println( frameRate ); // benchmark
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
