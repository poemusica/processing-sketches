class Theme
{
  int offset, r0, g0, b0;
  color theme1, theme2, theme, bgc;
  
  Theme()
  {
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
  }
  
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
  
  
}



