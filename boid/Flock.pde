class Flock
{
  Creature[] creatures;
  int size;
  PGraphics pg;
  Behavior behavior;
  
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
    pg = createGraphics( width, height );
    
    behavior = new Behavior( this );
    
    for ( int i = 0; i < size; i++ ) 
    {
      float x = random( width );
      float y = random( height );
      
      color fillColor = theme.lerpPerlinColor( i );
      color strokeColor = theme.perlinColor( i );
      
      Creature k = new Creature( x, y, fillColor, strokeColor, this );
      creatures[ i ] = k;
    }    
  }
  
  void draw()
  {
    pg.beginDraw();
    
    if ( !controls.buttons[(int)controls.buttonsIndex.get("trails")].state )
    { pg.background( 0, 0, 0, 0 ); }
    
    for ( Creature k : creatures )
    {
      k.update();
      k.move();
      k.draw( pg );
    }
    pg.endDraw();
    
    image( pg, 0, 0 );
  }
  
}
