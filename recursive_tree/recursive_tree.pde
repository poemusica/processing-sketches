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
  
  if ( len > 6 )
  {
    int n = int(random( 1, 4 ) );
    
    for ( int i = 0; i < n; i++ )
    {
      float randAng = random( -PI/2, PI/2 );
      float theta = map( noise( randAng, zPval ), 0, 1, -PI/2, PI/2 );
      pushMatrix();
      rotate( theta );
      branch( len, sw );
      popMatrix();
    }
  }
}
