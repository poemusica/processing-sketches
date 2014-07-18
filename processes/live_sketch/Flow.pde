
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
    cstroke = randomColor();
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
    stroke( 2 );
    stroke( c );
    cfill( c );
    
    for ( int c = 0; c < cols; c++ )
    {
      for ( int r=0; r < rows; r++ )
      {
        PVector v = field[ c ][ r ];
        pushMatrix();
        translate( v.x, v.y );
        rotate( v.heading() );
        triangle( -r, r/2, r, 0, -r, -r/2 );
        popMatrix();
      }
    }
  }
  
}


//  stroke( c );
//  fill( c );
//  strokeWeight( 1.5 );
//  translate( width/2, height/2);
//  line( 0, 0, 40, 0 );
//  triangle( 40, 5,  50, 0, 40, -5 );
