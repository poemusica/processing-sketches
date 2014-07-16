// Globals

Blob[] blobs = new Blob[ 80 ];

static float LOCAL_RANGE = 10; // multiplied by r
static float ALI_STRENGTH = 0.5;
static float COH_STRENGTH = 1;
static float SEP_STRENGTH = 3;
static float SEP_IDEAL = 18;
static float SWARM_STRENGTH = 2;
static float SCATTER_STRENGTH = 2;

// Defines Blob class
class Blob
{  
  // Instance variables
  PVector pos, vel, acc;
  color cstroke, cfill;
  float r; // radius of shape. can also be used as a visualizer for mass. 
  float maxSpeed = 5, maxForce;
  
  // Constructor
  Blob ( float x, float y ) 
  {
    pos = new PVector( x, y );
    vel = PVector.random2D(); // creates a PVector of length 1 pointing in a random direction.
    vel.setMag( random( 6, 12 ) / 100 );
    acc = new PVector( 0, 0 );
    //r = random(5, 15);
    r = 8;
    
    cstroke = randomColor();
    cfill = randomColor();
  }
  
  // Check edges & screen wrap
  void checkEdges()
  {
    float buffer = 2 * r;   
    if ( pos.x < -r ) { pos.x += width + buffer; }
    else if ( pos.x > width + r ) { pos.x -= width + buffer; }
    
    if ( pos.y < -r ) { pos.y += height + buffer; }
    else if ( pos.y > height + r ) { pos.y -= height + buffer; }
  }
  
  // Angle change for random motion
  float angleChange()
  {
    float limit = radians( 15 );
    float newAngle = random( -limit, limit );
    return newAngle;
  }
  
  // Wandering steering
  // I think this is just a more round-about way of doing what we were already doing...
  // At least it is consistent though.
  PVector wander()
  {
    PVector futurePos = PVector.add( pos, vel );
    PVector offset = PVector.mult( vel, 3 );
    float limit = 15;
    offset.rotate( radians( random( -limit, limit ) ) );
    PVector target =  PVector.add( pos, offset );
    
    PVector desired = PVector.sub( target, pos );
    desired.setMag(maxSpeed);
    
    PVector steer = PVector.sub( desired, vel );
    steer.limit(1);
    return steer;
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
  
  // Arrival steering
  PVector arrive(PVector target )
  {
    PVector desired = PVector.sub( target, pos );
    
    float d = desired.mag();
    if ( d < 100 )
    {
      float m = map( d, 0, 100, 0, maxSpeed );
      desired.setMag( m );
    }
    else { desired.setMag( maxSpeed ); }
      
    PVector steer = PVector.sub( desired, vel );
    steer.limit( SWARM_STRENGTH );
    return steer;
  }
    
  // Attraction steering
  PVector seek(PVector target)
  {
    PVector desired = PVector.sub( target, pos );
    desired.setMag( maxSpeed );
    PVector steer = PVector.sub( desired, vel );
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
    if ( !flockButton.state )
    {
      //random motion
      //vel.rotate(  angleChange() );
      PVector wanderForce = wander(); 
      vel.add( wanderForce );  
    } 
   
    if ( flockButton.state )
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
    
    if ( attractButton.state )
    {
      PVector seekForce = new PVector();
      seekForce = arrive( new PVector( mouseX, mouseY ) );
      applyForce( seekForce );
    }
    
    if ( repelButton.state )
    {
      PVector scary = new PVector( mouseX, mouseY );
      float d = pos.dist( scary );
      if ( d < r * LOCAL_RANGE )
      {
        PVector fleeForce = flee( scary );
        applyForce( fleeForce );
      }
      
    }
    
    vel.add( acc );
    vel.limit( maxSpeed );
    pos.add( vel );
    acc.mult( 0 );
    
    // debugging
    if ( this == blobs[ 0 ] ) 
      { println( pos, vel, flockButton.state ); }
    
    // screen wrap
    checkEdges();
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
