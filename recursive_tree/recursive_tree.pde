float zPval = 0.01;
long seed;

void setup()
{
  size( 600, 400 );
  seed = (long)random( 0, 1000 );
}

void draw()
{
  background( 255 );
  randomSeed( seed );
  float sw = 10;
  translate(  width/2, height );
  
  branch( 100, sw );
  zPval += 0.01;
}

void branch( float len, float sw )
{  
  
  strokeWeight( sw );
  line( 0, 0, 0, -len );
  translate( 0, -len );
  
  len *= 0.75;
  sw *= 0.75;
  
  if ( len > 10 )
  {
    int n = int(random( 1, 4 ) );
    
    for ( int i = 0; i < n; i++ )
    {
      float theta = random( -PI/4, PI/4 );
      float multiplier = ( 1 / ( 5 * len ) );
      float offset = map( noise( theta, zPval ), 0, 1, ( -PI * multiplier ), ( PI * multiplier ) );
      pushMatrix();
      rotate( theta + offset );
      branch( len, sw );
      popMatrix();
    }
  }
  else
  {
    fill( 0 );
    float r = random( 20, 40 );
    ellipse( 0, 0, r, r );
  }
}
