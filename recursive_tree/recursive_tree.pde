void setup()
{
  size( 600, 400 );
}

void draw()
{
  background( 255 );
  float sw = 10;
  translate(  width/2, height );
  float angle = map( mouseX, 0, width, 0, PI/2 );
  
  branch( 100, angle, sw );
}

void branch( float len, float theta, float sw )
{
  strokeWeight( sw );
  line( 0, 0, 0, -len );
  translate( 0, -len );
  
  len *= 0.75;
  sw *= 0.75;
  
  if ( len > 6 )
  {
    pushMatrix();
    rotate( theta );
    branch( len, theta, sw );
    popMatrix();
    
    pushMatrix();
    rotate( -theta );
    branch( len, theta, sw );
    popMatrix();
  }
}
