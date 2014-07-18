
FlowField randomFlow = new FlowField( 50 );

// Defines vector flow field class.
class FlowField
{
  int cellSize;
  int cols, rows;
  PVector [][] field;
  color lineColor;
  
  FlowField( int csize )
  {
    cellSize = csize;
    lineColor = randomColor();
    init();
  }
  
  void init()
  {
    cols = width / cellSize;
    rows = height / cellSize;
    field = new PVector [ cols ] [ rows ];
    for ( int c = 0; c < cols; c++ )
    {
      for ( int r = 0; r < rows; r++ )
      { field[ c ][ r ] = PVector.random2D();}
    } 
  }
  
  PVector lookup( PVector loc )
  {
    int column = int( constrain( loc.x / cellSize, 0, cols - 1 ) );
    int row = int( constrain( loc.y / cellSize, 0, rows -1) );
    return field[column][row].get();
  }
 
  void draw()
  {    
    PVector loc = new PVector( cellSize / 2, cellSize / 2 );
    for ( int c = 0; c < cols; c++ )
    {
      for ( int r=0; r < rows; r++ )
      {
        arrow(  loc.x, loc.y, field[ c ][ r ], lineColor );
        loc.y += cellSize;
      }
      loc.y = cellSize / 2;
      loc.x += cellSize;
    }
  }
  
}

// UTILITIES


void arrow( float x, float y, PVector v, color c )
{
  stroke( c );
  strokeWeight( 1 );
  pushMatrix();
  translate( x, y );
  rotate( v.heading() );
  line( -25, 0, 25, 0 );
  line( 15, 5, 25, 0 );
  line( 15, -5, 25, 0 );
  popMatrix();
}



