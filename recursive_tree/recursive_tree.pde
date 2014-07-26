void setup()
{
  size( 600, 400 );
  strokeWeight( 2 );
}

void draw()
{
  background( 255 );
  
  translate(  width/2, height );
  branch( 100 );
}

void branch( float len )
{
  line( 0, 0, 0, -len );
  translate( 0, -len );
  
  len *= 0.75;
  
  if ( len > 6 )
  {
    pushMatrix();
    rotate( PI/6 );
    branch( len );
    popMatrix();
    
    pushMatrix();
    rotate( -PI/6 );
    branch( len );
    popMatrix();
  }
}
