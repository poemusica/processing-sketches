
FlowField randomFlow = new FlowField( 10 );

// Defines vector flow field class.
class FlowField
{
  PVector [][] field;
  int resolution;
  int cols, rows;
  color c;
  float r;
  
  FlowField( int r )
  {
    resolution = r;
    cols = width / resolution;
    rows = height / resolution;
    field = new PVector [ cols ] [ rows ];
    c = randomColor();
    r = 2;
    init();
  }
  
  void init()
  {
    for ( int c = 0; c < cols; c++ )
    {
      for ( int r = 0; r < rows; r++ )
      { field[ c ][ r ] = PVector.random2D(); }
    } 
  }
  
  PVector lookup( PVector loc )
  {
    int column = int( constrain( loc.x / resolution, 0, cols - 1 ) );
    int row = int( constrain( loc.y / resolution, 0, rows -1) );
    return field[column][row].get();
  }
 
  void draw()
  {    
    for ( int c = 0; c < cols; c++ )
    {
      for ( int r=0; r < rows; r++ )
      {
        Arrow a = new Arrow();
        a.display( v, c );
      }
    }
  }
  
}

// Arrow Shape

class Arrow
{
  void display( PVector v, color c )
  {
    stroke( c );
    fill( c );
    strokeWeight( 1 );
    pushMatrix();
    translate( v.x, v.y );
    rotate( v. heading() );
    line( 0, 0, 40, 0 );
    line( 40, 5, 50, 0 );
    line( 40, -5, 50, 0 );
    popMatrix();
  }
}


