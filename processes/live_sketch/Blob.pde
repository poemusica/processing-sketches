// Globals

Blob[] blobs = new Blob[ 40 ];

static float ALI_STRENGTH = 1;
static float COH_STRENGTH = 1;
static float SEP_STRENGTH = 3;
static float SEP_IDEAL = 16;

// Defines Blob class
class Blob
{  
  // instance variables
  PVector pos, vel;
  color cstroke, cfill;
  
  Blob ( float x, float y ) 
  {
    pos = new PVector( x, y );
    vel = PVector.random2D();
    vel.setMag( 1.275 );
    
    cstroke = randomColor();
    cfill = randomColor();
  }
  
  void update()
  {
    if ( !FLOCKING )
    {
      //random motion
      vel.rotate(  angleChange() );  
    } 
    
    else
    {
      // flocking
      
      PVector coh = new PVector( 0, 0 );
      PVector sep = new PVector( 0, 0 );
      PVector ali = new PVector( 0, 0 );
      
      float n = blobs.length;
      PVector v = new PVector( 0, 0 );
      Blob b;
      
      for ( int i = 0; i < n; i++ )
      {
        b = blobs[ i ];
        if ( b == this ) { continue; }
        
        coh.add( b.pos );
        ali.add( b.vel );
        
        if ( pos.dist( b.pos ) < SEP_IDEAL ) 
        {
          sep.add( PVector.sub( pos, b.pos ) );
        }
        
      }
      
      ali.div( n - 1 );
      ali.sub( pos );
      ali.setMag( ALI_STRENGTH );
      vel.add( ali );
      
      coh.div( n - 1 );
      coh.sub( pos );
      coh.setMag( COH_STRENGTH );
      vel.add( coh );
      
      sep.setMag( SEP_STRENGTH );
      vel.add( sep );
      
    }
    
    vel.limit( 5 );
    pos.add( vel );
    
    // screen wrap  
    if ( pos.x < -8 ) 
    {
      pos.x = width + 8;
    } else if ( pos.x > width + 8 )
    {
      pos.x = -8;
    }
    if ( pos.y < -8 )
    {
      pos.y = height + 8;
    } else if ( pos.y > height + 8 )
    {
      pos.y = -8;
    }
  }
      
      
  void draw()
  {
    stroke( 2 );
    stroke( cstroke );
    fill( cfill );
    ellipse( pos.x, pos.y, 8, 8 );
  }
}
