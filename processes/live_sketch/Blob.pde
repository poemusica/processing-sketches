// Globals

Blob[] blobs = new Blob[ 80 ];

static float LOCAL_RANGE = 10; // multiplied by r
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
  int r = 8;
  
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
        
        float d = pos.dist( b.pos );
        if ( d > r * LOCAL_RANGE ) { continue; }
        
        v = PVector.sub( b.pos, pos );
        v.normalize();
        v.div( sq( d ) );
        coh.add( v );
        
        if ( d < SEP_IDEAL ) 
        {
          sep.add( PVector.sub( pos, b.pos ) );
        }
        
        ali.add( b.vel );
        
      }

      coh.setMag( COH_STRENGTH );
      vel.add( coh );
      
      sep.setMag( SEP_STRENGTH );
      vel.add( sep );
      
      ali.div( n - 1 );
      ali.setMag( ALI_STRENGTH );
      vel.add( ali );
      
    }
    
    vel.limit( 5 );
    pos.add( vel );
    
    // screen wrap
    int buffer = 2 * r;   
    if ( pos.x < -r ) { pos.x += width + buffer; }
    else if ( pos.x > width + r ) { pos.x -= width + buffer; }
    
    if ( pos.y < -r ) { pos.y += height + buffer; }
    else if ( pos.y > height + r ) { pos.y -= height + buffer; }
  }
      
      
  void draw()
  {
    stroke( 2 );
    stroke( cstroke );
    fill( cfill );
    ellipse( pos.x, pos.y, r, r );
  }
}
