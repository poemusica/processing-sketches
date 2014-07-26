void setup()
{
  size( 600, 400 );
  strokeWeight( 2 );
}

void draw()
{
  background( 255 );
  
  translate(  width/2, height );
  float angle = map( mouseX, 0, width, 0, PI/2 );
  
  branch( 100, angle );
}

void branch( float len, float theta )
{
  line( 0, 0, 0, -len );
  translate( 0, -len );
  
  len *= 0.75;
  
  if ( len > 6 )
  {
    pushMatrix();
    rotate( theta );
    branch( len, theta );
    popMatrix();
    
    pushMatrix();
    rotate( -theta );
    branch( len, theta );
    popMatrix();
  }
}
