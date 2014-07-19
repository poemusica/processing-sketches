
FlowField perlinFlow = new FlowField( 20 );

// Defines vector flow field class.
class FlowField
{
  int cellSize;
  int cols, rows;
  PVector [][] field;
  color lineColor;
  float perlinBias;
  float z = 0;
  
  FlowField( int csize )
  {
    cellSize = csize;
    lineColor = randomColor();
    perlinBias = random( 1, 360 );
    init();
  }
  
  void init()
  {
    cols = width / cellSize;
    rows = height / cellSize;
    field = new PVector [ cols ] [ rows ];
    
    float zoff = z;
    float xoff = 0;
    for ( int c = 0; c < cols; c++ )
    {
      float yoff = 0;
      for ( int r = 0; r < rows; r++ )
      { 
        float angle = map( noise( xoff, yoff, zoff ), 0, 1, 0, TWO_PI );
        angle += radians( perlinBias );
        field [ c ][ r ] = new PVector( cos( angle ), sin( angle ) );
        //field [ c ][ r ] = PVector.random2D();
        yoff += 0.1;
      }
      xoff += 0.1;
    } 
  }
 
  PVector lookup( PVector loc )
  {
    int column = int( constrain( loc.x / cellSize, 0, cols - 1 ) );
    int row = int( constrain( loc.y / cellSize, 0, rows -1) );
    return field[column][row].get();
  }
 
  void update()
  {
    if ( frameCount % 10 == 0 )
    {
      z += 0.1;
      perlinBias += random( -5, 5 );
      init();
    }
  }
  
  void draw()
  {      
    PVector loc = new PVector( cellSize / 2, cellSize / 2 );
    for ( int c = 0; c < cols; c++ )
    {
      loc.y = cellSize / 2;
      for ( int r=0; r < rows; r++ )
      {
        arrow(  loc.x, loc.y, field[ c ][ r ], lineColor );
        loc.y += cellSize;
      }
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
  line( -8, 0, 8, 0 );
  line( 3, -3, 8, 0 );
  line( 3, 3, 8, 0 );
  popMatrix();
}



