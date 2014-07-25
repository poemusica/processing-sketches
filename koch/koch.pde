
class KochLine
{
  PVector start, end;
  
  KochLine(PVector a, PVector b)
  {
    start = a.get();
    end = b.get();
  }
  
  void display()
  {
    stroke(0);
    line(start.x, start.y, end.x, end.y);
  }
 
}
