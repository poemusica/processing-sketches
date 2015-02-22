
class KochLine
{
  PVector start, end;
  float angle = 140;
  
  KochLine( PVector a, PVector b )
  {
    start = a.get();
    end = b.get();
  }
  
  PVector kochA()
  {
    return start.get();
  }
  
  PVector kochB()
  {
    PVector v = PVector.sub( end, start );
    v.div( 3 );
    v.add( start );
    return v;
  }

  PVector kochC()
  {
    PVector b = kochB();
    PVector v = PVector.sub( b, start );
    v.rotate( -radians( 60 ) );
    b.add( v );
    return b;
  }

  PVector kochD()
  {
    PVector v = PVector.sub( end, start );
    v.mult( 2/3.0 );
    v.add( start );
    return v;
  }

  PVector kochE()
  {
    return end.get();
  }
 
  void display()
  {
    stroke( 0 );
    line( start.x, start.y, end.x, end.y );
  }
 
}

