float zPval = 0.01;

void setup()
{
  size( 600, 400 );
}

void draw()
{
  background( 255 );
  float sw = 10;
  translate(  width/2, height );
  float xPval = 0.01; 
  float yPval = 0.01;
  
  branch( 100, sw, xPval, yPval );
  zPval += 0.01;
}

void branch( float len, float sw, float xPval, float yPval )
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
        float theta = map( noise( xPval, yPval, zPval ), 0, 1, -PI/2, PI/2 ); 
        pushMatrix();
        rotate( theta );
        branch( len, sw, xPval + 0.01 , yPval + 0.01 );
        popMatrix();
    }
  }
}
