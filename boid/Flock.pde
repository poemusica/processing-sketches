class Flock
{
  Creature[] creatures;
  int size;
  PGraphics pg;
  
  Flock( int n )
  {
    size = n;
    creatures = new Creature[ size ];
    pg = createGraphics( width, height );
    
    for ( int i = 0; i < size; i++ ) 
    {
      float x = random( width );
      float y = random( height );
      
      color fillColor = lerpPerlinColor( i );
      color strokeColor = perlinColor( i );
      
      Creature b = new Creature( x, y, fillColor, strokeColor );
      creatures[ i ] = b;
    }    
  }
  
  void draw()
  {
    pg.beginDraw();
    
    if ( !controls.buttons[(int)controls.buttonsIndex.get("trails")].state )
    { pg.background( 0, 0, 0, 0 ); }
    
    for ( Creature b : creatures )
    {
      b.update();
      b.draw( pg );
    }
    pg.endDraw();
    
    image( pg, 0, 0 );
  }
  
}
