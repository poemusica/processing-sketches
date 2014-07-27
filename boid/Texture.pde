class Texture
{
  PGraphics buffer;
  color base;
  int offset;
  
  Texture( color c )
  {
    buffer = createGraphics( width, height );
    base = c;
    offset = 75;
    
    buffer.beginDraw();
    for ( int x = 0; x < width; x++ )
    {
      for ( int y = 0; y < height; y++ )
      {
        buffer.set( x, y, perlinPixel( float( x ) / 100, float( y ) / 100 ) );
      }
    }
    buffer.endDraw(); 
  }
  
  color perlinPixel( float x, float y )
  {
    float rval = noise( x, y );
    int r1 = int( map( rval, 0, 1, -offset, offset ) );
    
    float gval = noise( x, y );
    int g1 = int( map( gval, 0, 1, -offset, offset ) );
    
    float bval = noise( x, y );
    int b1 = int( map( bval, 0, 1, -offset, offset ) );
    
    color c = color( red( base ) + r1, green( base ) + g1, blue( base ) + b1, 255 );
    return c;
  }
  
  void draw()
  {
    image( buffer, 0, 0 );
  }
}
