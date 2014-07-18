
FlowField randomFlow = new FlowField( 10 );

// Defines vector flow field class.
class FlowField
{
  int resolution;
  int cols, rows;
  PVector [][] field;
  color lineColor;
  
  FlowField( int res )
  {
    resolution = res;
    cols = width / resolution;
    rows = height / resolution;
    field = new PVector [ cols ] [ rows ];
    lineColor = randomColor();
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
    PVector loc = new PVector( resolution / 2, resolution / 2 );
    for ( int c = 0; c < cols; c++ )
    {
      for ( int r=0; r < rows; r++ )
      {
        arrow(  loc.x, loc.y, field[ c ][ r ], lineColor );
        loc.x += resolution;
      }
      loc.y += resolution;
    }
  }
  
}

// UTILITIES


void arrow( float x, float y, PVector v, color c )
{
  stroke( c );
  strokeWeight( 1 );
  pushMatrix();
  translate( v.x, v.y );
  rotate( v. heading() );
  line( 0, 0, 40, 0 );
  line( 40, 5, 50, 0 );
  line( 40, -5, 50, 0 );
  popMatrix();
}



