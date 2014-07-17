// Globals

Blob[] blobs = new Blob[ 40 ];

static float LOCAL_RANGE = 32; // multiplied by r
static float WANDER_STRENGTH = 1;
static float ALI_STRENGTH = 0.5;
static float COH_STRENGTH = 0.5;
static float SEP_STRENGTH = 1.5;
static float PROX_IDEAL = 16;
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
    vel.setMag( 1.25 );
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
    
  // Apply force to acceleration
  void applyForce( PVector force)
  {
    acc.add( force );
  }
    
  // Wandering steering.
  PVector wander()
  {
    PVector futpos = PVector.add( pos, vel );
    PVector offset = vel.get();
    offset.div( 3 );
    offset.rotate( radians( random( 0, 360 ) ) );
    PVector target = PVector.add( futpos, offset );
    
    PVector desired = PVector.sub( target, pos );
    desired.setMag( maxSpeed );
    
    PVector steer = PVector.sub( desired, vel );
    steer.limit( WANDER_STRENGTH );
    return steer;
  }
    
  // Separation steering
  PVector separate()
  {
    int near = 0;
    PVector sum = new PVector( 0 , 0 );
    for ( Blob b : blobs )
    {
      if ( b == this ) { continue; }
      
      float d = PVector.dist( pos, b.pos );
      
      if ( d < PROX_IDEAL )
      { 
        PVector diff = PVector.sub( pos, b.pos ); 
        diff.div( d );
        sum.add( diff );
        near++;
      }  
    }
    if ( near > 0 )
    {
      sum.div( near ); 
      sum.setMag( maxSpeed );
    }
     
    PVector steer = PVector.sub( sum, vel ); 
    steer.limit( SEP_STRENGTH );
    return steer;   
  }
  
  // Cohesion steering
  PVector cohere()
  {
    int local = 0;
    PVector sum = new PVector( 0, 0 );
    for ( Blob b : blobs )
    {
      if ( b == this ) { continue; }
      
      float d = pos.dist( b.pos );
      if ( d > r * LOCAL_RANGE ) { continue; }
      
      if ( d > PROX_IDEAL )
      {
        sum.add( PVector.sub( b.pos, pos ) );
        local++;
      }
     }
     
     if ( local > 0 )
     {
       sum.div( local );
       sum.setMag( maxSpeed );
     }  
     
     PVector steer = PVector.sub( sum, vel ); 
     steer.limit( COH_STRENGTH );
     return steer;       
  }
  
  // Alignment steering
  PVector align()
  {
    int local = 0;
    PVector sum = new PVector( 0, 0 );
    for ( Blob b : blobs )
    {
      if ( b == this ) { continue; }
      
      float d = pos.dist( b.pos );
      if ( d > r * LOCAL_RANGE ) { continue; }
     
      sum.add( b.vel );
      local++;
     }
     
     if ( local > 0 )
     {
       sum.div( local );
       sum.setMag( maxSpeed );
     }
     
     PVector steer = PVector.sub( sum, vel ); 
     steer.limit( ALI_STRENGTH );
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
    PVector steer = new PVector( 0, 0 );
    float d = pos.dist( target );
    if ( d < r * LOCAL_RANGE )
    {
      PVector desired = PVector.sub( target, pos );
      desired.setMag( maxSpeed );
      steer = PVector.sub( desired, vel );
      steer.limit( SWARM_STRENGTH );
    }
    return steer;
  }
  
  // Aversion steering
  PVector flee(PVector target)
  {
    PVector steer = new PVector( 0, 0 );
    float d = pos.dist( target );
    if ( d < r * LOCAL_RANGE )
    {
      PVector desired = PVector.sub( pos, target );
      desired.setMag( maxSpeed );
      steer = PVector.sub( desired, vel);
      steer.limit( SCATTER_STRENGTH );
    }
    return steer;
  }
  
  // Update
  void update()
  {
    //random motion
    applyForce( wander() );
    
    // flocking
    if ( flockButton.state )
    {
      applyForce( cohere() );
      applyForce( separate() );
      applyForce( align() );
    }
    
    // attraction
    if ( attractButton.state )
    {
      PVector target = new PVector( mouseX, mouseY );
      applyForce( seek( target ) );
    }
    
    // aversion
    if ( repelButton.state )
    {
      PVector target = new PVector( mouseX, mouseY );
      applyForce( flee( target ) );
    }
    
    // velocity and position change
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
    float rotation = vel.heading();
    stroke( 2 );
    stroke( cstroke );
    fill( cfill );
    
    pushMatrix();
    translate( pos.x, pos.y );
    rotate( rotation );
    
    triangle( -r, r/2, r, 0, -r, -r/2 );
    popMatrix();
    
  }
}
