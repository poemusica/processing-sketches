// Globals

Blob[] blobs = new Blob[ 80 ];

static float LOCAL_RANGE = 10; // multiplied by r
static float ALI_STRENGTH = 1;
static float COH_STRENGTH = 1;
static float SEP_STRENGTH = 3;
static float SEP_IDEAL = 16;
static float SWARM_STRENGTH = 2;
static float SCATTER_STRENGTH = 2;

// Defines Blob class
class Blob
{  
  // Instance variables
  PVector pos, vel, acc;
  color cstroke, cfill;
  int r = 8, maxSpeed = 5, maxForce;
  
  // Constructor
  Blob ( float x, float y ) 
  {
    pos = new PVector( x, y );
    vel = PVector.random2D();
    vel.setMag( 1.275 );
    acc = new PVector( 0, 0 );
    
    cstroke = randomColor();
    cfill = randomColor();
  }
  
  // Angle change for random motion
  float angleChange()
  {
    float limit = radians( 15 );
    float magic = random( -limit, limit );
    return magic;
  }
  
  // Apply force to acceleration
  void applyForce( PVector force)
  {
    acc.add( force );
  }
  
  // Separation steering
  PVector separate( float d, PVector other)
  {
    PVector steer = new PVector( 0, 0 );
    if ( d < SEP_IDEAL )
    {
      steer = PVector.sub( pos, other );
    }
    return steer;
  }
  
  // Cohesion steering
  PVector cohere( float d, PVector other)
  {
    PVector steer = PVector.sub( other, pos );
    steer.normalize();
    steer.div( sq( d ) );
    return steer;
  }
  
  // Attraction steering
  PVector seek(PVector target)
  {
    PVector desired = PVector.sub( target, pos );
    desired.setMag( maxSpeed );
    PVector steer = PVector.sub( desired, vel);
    steer.limit( SWARM_STRENGTH );
    return steer;
  }
  
  // Aversion steering
  PVector flee(PVector target)
  {
    PVector desired = PVector.sub( pos, target );
    desired.setMag( maxSpeed );
    PVector steer = PVector.sub( desired, vel);
    steer.limit( SCATTER_STRENGTH );
    return steer;
  }
  
  // Update
  void update()
  {
    if ( !FLOCKING )
    {
      //random motion
      vel.rotate(  angleChange() );  
    } 
   
    if ( FLOCKING )
    {
      // flocking
      
      PVector coh = new PVector( 0, 0 );
      PVector sep = new PVector( 0, 0 );
      PVector ali = new PVector( 0, 0 );
      float n = blobs.length;
      
      // accumulate each force
      for ( Blob b : blobs )
      {
        if ( b == this ) { continue; }
        
        float d = pos.dist( b.pos );
        if ( d > r * LOCAL_RANGE ) { continue; }
        
        coh.add( cohere( d, b.pos ) );
        
        sep.add( separate( d, b.pos ) );
        
        ali.add( b.vel );
      }
      
      // scale each force
      coh.setMag( COH_STRENGTH );
      applyForce( coh );
      
      sep.setMag( SEP_STRENGTH );
      applyForce( sep );
      
      ali.div( n - 1 );
      ali.setMag( ALI_STRENGTH );
      applyForce( ali );
    }
    
    if ( ATTRACT )
    {
      PVector seek = new PVector();
      seek = seek( new PVector( mouseX, mouseY ) );
      applyForce( seek );
    }
    
    if ( REPEL )
    {
      PVector scary = new PVector( mouseX, mouseY );
      float d = pos.dist( scary );
      if ( d < r * LOCAL_RANGE )
      {
        PVector flee = flee( scary );
        applyForce( flee );
      }
      
    }
    
    vel.add( acc );
    vel.limit( maxSpeed );
    pos.add( vel );
    acc.mult(0);
    
    // screen wrap
    int buffer = 2 * r;   
    if ( pos.x < -r ) { pos.x += width + buffer; }
    else if ( pos.x > width + r ) { pos.x -= width + buffer; }
    
    if ( pos.y < -r ) { pos.y += height + buffer; }
    else if ( pos.y > height + r ) { pos.y -= height + buffer; }
  }
      
  // Draw    
  void draw()
  {
    stroke( 2 );
    stroke( cstroke );
    fill( cfill );
    ellipse( pos.x, pos.y, r, r );
  }
}
