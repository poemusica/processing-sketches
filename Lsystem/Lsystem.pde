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
  String next;
  
  LSystem( String axiom )
  {
    current = axiom;
    next = "";
  }
  
  void applyRules()
  {
    for ( int i = 0; i < current.length(); i++ )
   {
     char c = current.charAt( i );
     if ( c == 'A' )
     {
       next += "AB";
     }
     if ( c == 'B' )
     {
       next += "A";
     }
   }
  current = next; 
  }
}

void mousePressed()
{
  lsys.applyRules();
  println( lsys.current );
}
