//Globals
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
  Arrow arrow;
  
  FlowField( int csize )
  {
    cellSize = csize;
    lineColor = randomColor();
    perlinBias = random( 1, 360 );
  }
  
  void init()
  {
    cols = width / cellSize;
    rows = height / cellSize;
    field = new PVector [ cols ] [ rows ];
    arrow = new Arrow( 16 );
    
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
      perlinBias += random( -15, 15 );
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
        pushMatrix();
        translate(loc.x, loc.y);
        rotate(field[c][r].heading());
        arrow.display();
        popMatrix();
        loc.y += cellSize;
      }
      loc.x += cellSize;
    }
  }
  
}

// Defines Arrow shape

class Arrow
{
  PShape s;
  float l;
  
  Arrow(int len) {
    l = len;
    
    s = createShape();
    s.beginShape();
    s.stroke(0);
    s.fill( 0xFF33FFCC );
    s.strokeWeight(1);
    
    s.vertex(-l/2, 0);
    s.vertex(l/2, 0);
    
    s.beginContour();
    s.vertex(-l/5, -l/5);
    s.vertex(l/2, 0);
    s.vertex(-l/5, l/5);
    s.endContour();
    
    s.endShape();
  }
  
  void display()
  {
    shape(s);
  }
}

// UTILITIES


//void drawArrow()
//{
//  arrow = createGraphics( width, height );
//  arrow.beginDraw();
//  arrow.beginShape(QUADS);
//  arrow.line( -8, 0, 8, 0 );
//  arrow.line( 3, -3, 8, 0 );
//  arrow.line( 3, 3, 8, 0 );
//  arrow.endShape();
//  arrow.endDraw();
//}
