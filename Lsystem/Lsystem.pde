LSystem lsys;

void setup()
{
  size( 600, 400 );
  lsys = new LSystem( "A" );
}

void draw()
{
  background(255);
}

class LSystem
{
  String current;
  
  LSystem( String axiom )
  {
    current = axiom;
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
}

void mousePressed()
{
  lsys.applyRules();
  println( lsys.current );
}
