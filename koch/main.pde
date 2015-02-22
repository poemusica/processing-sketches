ArrayList<KochLine> lines1;
ArrayList<KochLine> lines2;
ArrayList<KochLine> lines3;

int num = 0;

void setup()
{
  size( 600, 300 );
  lines1 = new ArrayList<KochLine>();
  PVector start1 = new PVector( 0, 200 );
  PVector end1 = new PVector( width/3, 200 );
  lines1.add( new KochLine( start1, end1 ) );
  
  lines2 = new ArrayList<KochLine>();
  PVector start2 = new PVector( width/3, 200 );
  PVector end2 = new PVector( 2 * width/3, 200 );
  lines2.add( new KochLine( start2, end2 ) );
  
  for ( int i = 0; i < 5; i++ )
  {
    generate( lines1 );
    //generate( lines2 );
  }
}


void draw()
{
  background( 255 );

  for ( int i = 0; i < num; i++ )
  {
    KochLine l1 = lines1.get(i);
    l1.display();
    //KochLine l2 = lines2.get(i);
    //l2.display();
  }
  if ( num < lines1.size() ) { num ++; }
  
}


void generate( ArrayList<KochLine> lines )
{
  ArrayList next = new ArrayList<KochLine>();
  for ( KochLine l : lines)
  {
    PVector a = l.kochA();
    PVector b = l.kochB();
    PVector c = l.kochC();
    PVector d = l.kochD();
    PVector e = l.kochE();
    
    next.add( new KochLine( a, b) );
    next.add( new KochLine( b, c) );
    next.add( new KochLine( c, d) );
    next.add( new KochLine( d, e) );
  }
  lines = next;
}
