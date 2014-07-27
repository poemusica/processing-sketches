LSystem lsys;

void setup()
{
  size( 600, 400 );
  background(255);
  strokeWeight( 1 );
  stroke( 0 );
  lsys = new LSystem( "F", height / 3.5, radians( 25 ) );
}

void draw()
{
  translate( width / 2, height );
  rotate( PI );
}

class LSystem
{
  String current;
  float len, theta;
  
  LSystem( String axiom, float l, float t )
  {
    current = axiom;
    len = l;
    theta = t;
  }
  
  void applyRules()
  {
    StringBuffer next = new StringBuffer(); 
    for ( int i = 0; i < current.length(); i++ )
   {
     char c = current.charAt( i );
     if ( c == 'A' )
     {
       next.append( "AB" );
     }
     if ( c == 'B' )
     {
       next.append( "A" );
     }
   }
  current = next.toString(); 
  }
  
  void applyLRules()
  {
    StringBuffer next = new StringBuffer();
    for ( int i =0; i < current.length(); i++ )
    {
      char letter = current.charAt( i );
      switch ( letter )
      {
        case 'F':
          line( 0, 0, 0, len ); translate( 0, len );
          next.append( "FF+[+F-F-F]-[-F+F+F]" );
          break;
        case 'G':
          translate( 0, len );
          next.append( "G" );
          break;
        case '+':
          rotate( -theta );
          next.append( "+" );
          break;
        case '-':
          rotate( theta );
          next.append( "-" );
          break;
        case '[':
          pushMatrix();
          next.append( "[" );
          break;
        case ']':
          popMatrix();
          next.append( "]" );
          break;
      }
    }
    len *= 0.5;
    current = next.toString();   
  }
  
}

void mousePressed()
{
  lsys.applyLRules();
  println( lsys.current );
}
