class Flock
{
  Creature[] creatures;
  int size, trailDelay, trailFade;
  Behavior behavior;
  
  PGraphics pg1, pg2;
  color theme1, theme2, ptheme;
  
  float localRange = 60;
  float wanderStrength = 1;
  float aliStrength = 1;
  float cohStrength = 1;
  float sepStrength = 1.5;
  
  float seekStrength = cohStrength * 1.75;
  float fleeStrength = sepStrength * 1.75;
  
  float wallStrength = 2;
  float flowStrength = 0.5;
  float proxMin =  30;
  float proxMax = 45;
  
  Flock( int n )
  {
    size = n;
    creatures = new Creature[ size ];    
    behavior = new Behavior( this );
    
    pg1 = createGraphics( width, height );
    pg2 = createGraphics( width, height );
    trailDelay = 1;
    trailFade = 220;
    theme1 = theme.randomColor( 0, 255 );
    theme2 = theme.randomColor( 0, 255 );
    ptheme = theme.randomColor( 75, 255 - 75 );
    
    for ( int i = 0; i < size; i++ ) 
    {
      float x = random( width );
      float y = random( height );
      
      color fillColor = theme.lerpPerlinColor( i, theme1, theme2 );
      color strokeColor = theme.perlinColor( i, ptheme, 75 );
      
      Creature k = new Creature( x, y, fillColor, strokeColor, this );
      creatures[ i ] = k;
    }    
  }
  
  void draw()
  {
    pg2.beginDraw();
    pg2.background( 0, 0, 0, 0 );
    if ( controls.buttons[(int)controls.buttonsIndex.get("trails")].state && ( frameCount % trailDelay == 0 ) )
    {
     pg2.tint( 255, trailFade );
     pg2.image( pg1.get(), 0, 0 ); 
    }
    pg2.endDraw();
    
    pg1.beginDraw();
    pg1.background( 0, 0, 0, 0 );
    pg1.image( pg2, 0, 0 );
    pg1.tint( 255, 255 );
    for ( Creature k : creatures )
    {
      k.update();
      k.move();
      k.draw( pg1 );
    }
    pg1.endDraw();
    
    image( pg1, 0, 0 );
  }
  
}


ArrayList<Flock> makeFlocks( int lo, int hi )
{
  ArrayList<Flock> flocks;
 flocks = new ArrayList<Flock>(); 
  int i = hi;
  while ( i >= lo )
  {
    int num = int( random( lo, i ) );
    Flock f = new Flock( num );
    flocks.add( f );
    i -= num;
  }
  return flocks;
}
