
void setup()
{
  size( 600, 400 );
}

void draw()
{
  background( 255 );
  float sw = 10;
  translate(  width/2, height );
  
  branch( 100, sw );
  noLoop();
}

void branch( float len, float sw )
{  
  float theta = random( 0, PI/3 );
  strokeWeight( sw );
  line( 0, 0, 0, -len );
  translate( 0, -len );
  
  len *= 0.75;
  sw *= 0.75;
  
  if ( len > 6 )
  {
    pushMatrix();
    rotate( theta );
    branch( len, sw );
    popMatrix();
    
    pushMatrix();
    rotate( -theta );
    branch( len, sw );
    popMatrix();
  }
}

void mouseClicked() {
  
  loop();

}
