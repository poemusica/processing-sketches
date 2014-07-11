
// GLOBAL VARIABLES //

Blob[] blobs = new Blob[ 10 ];
Button toggle = new Button();

boolean FLOCKING = true;

// MAIN SETUP AND DRAWING //

// Setup the Processing Canvas
void setup()
{
  size( 500, 500 );
  smooth();
  frameRate( 30 );
  
  for ( int i = 0; i < blobs.length; i++ ) 
  {
    float x = random( width );
    float y = random( height );
    Blob b = new Blob( x, y );
    blobs[ i ] = b;
  }

}

// Main draw loop
void draw()
{
  background(0xFF33FFCC);
  
  for ( int i = 0; i < blobs.length; i++ )
  {
    Blob b = blobs[ i ];
    b.update();
    b.draw();
  }
  
  toggle.draw();

}

// UTILITIES //

// Make a random color.
color random_color() 
{
  return color( random(255), random(255), random(255), 220 );
}

float angle_change()
{
  float limit = radians( 10 );
  float magic = random( -limit, limit );
  return magic;
}

// CLASSES //

// Defines Toggle button
class Button
{
  color cstroke, cfill;
  String toggle_text = "Toggle flocking";
  
  Button ()
  {
    cstroke = random_color();
    cfill = random_color();
  }
  
  void draw( ) 
  {
    strokeWeight( 3 );
    stroke( cstroke );
    fill( cfill );
    rect( 25, 430, 100, 45, 10 );
    textSize( 12 );
    fill( 0,0,0 );
    text( toggle_text, 30, 458 );
  }
  
}

// Defines Blob class
class Blob
{
  float x, y, speed, angle;
  color cstroke, cfill;
  
  Blob ( float posx, float posy ) 
  {
    x = posx;
    y = posy;
    speed = 1.275;
    angle = radians( random( 359 ) );
    cstroke = random_color();
    cfill = random_color();
  }
  
  // Alignement
  float align()
  {
    float new_angle = 1.0;
    
    for ( int i = 0; i < blobs.length; i++ )
    {
      
      Blob b = blobs[ i ];
      
      if ( b != this )
      {
        new_angle += b.angle;
      }
      
    }
    new_angle = new_angle / blobs.length;
    return new_angle / 8;
  }
  
  // Cohesion
  float [] cohere()
  {
    float center_x = 0;
    float center_y = 0;
    
    for ( int i = 0; i < blobs.length; i++ )
    {
      Blob b = blobs[ i ];
      if ( b != this )
      {
        center_x += b.x;
        center_y += b.y;
      }
      
      float n = blobs.length;
      center_x = center_x / ( n - 1 );
      center_y = center_y / ( n - 1 );
    }
    float[] offset = { center_x / 10, center_y / 10 };
    return offset;
  }

  // Separation
  float[] separate()
  {
    float ideal = 5;
    float dx = 0;
    float dy = 0;
    
    for ( int i = 0; i < blobs.length; i++ )
    {
      Blob b = blobs[ i ];
      if ( b != this ) 
      {
        float d = dist( b.x, b.y, x, y );
        if ( d < ideal )
        {
          dx = dx - ( b.x - x );
          dy = dy - (b.y - y );
        }
      }
    } 
  
  float[] offset = { dx, dy };
  return offset;
  }


  void update()
  {
    if ( !FLOCKING )
    {
      angle = ( angle + angle_change() % ( 2 * PI) );
      float dx = cos( angle ) * speed;
      float dy = sin( angle ) * speed;
      x += dx;
      y += dy;
    } else
    {
      float[] sep = separate(); 
      float [] coh = cohere();
      x += sep[ 0 ] + coh[ 0 ];
      y += sep[ 1 ] + coh[ 1 ];
      angle += align() % ( 2 * PI );
    }
    
    float dx = cos( angle ) * speed;
    float dy = sin( angle ) * speed;
    x += dx;
    y += dy;
    
    if ( x < 0 ) 
    {
      x = width;
    } else if ( x > width )
    {
      x = 0;
    }
    if ( y < 0 )
    {
      y = height;
    } else if ( y > height )
    {
      y = 0;
    }
  }
      
      
  void draw()
  {
    stroke( 2 );
    stroke( cstroke );
    fill( cfill );
    ellipse( x, y, 8, 8 );
    //float x1 = x - 8;
    //flo = y - 8;
    //float y3 = y + 8;
    //triangle( x1, y1, x, y, x1, y3 );
  }
}
