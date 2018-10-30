// Tony Reksoatmodjo
// Classes

// --- VECTOR CLASS ---
//  Barebones Vector Class
//
class Vector{
  public int x = 0;
  public int y = 0;
  int thickness;
  color lineColor;
  color pointColor;
  color textColor;
  color default_color = color(peppermint, 16);
  //public int length = 0.0;
  
  Vector(int X, int Y){
    x = X;
    y = Y;

    lineColor = default_color;
    pointColor = default_color;
    //length = Math.sqrt((x*x) + (y*y));
  }
  
  Vector(int X, int Y, color newlc, color newpc){
   x = X;
   y = Y;
   lineColor = newlc;
   pointColor = newpc;
  }
  
  Vector(Vector old){
    x = old.x;
    y = old.y;
    lineColor = old.lineColor;
    pointColor = old.pointColor;
  }
  
  void add(Vector v){
     x += v.x;
     y += v.y;
  }
  
  void sub(Vector v){
     x -= v.x;
     y -= v.y;
  }
  
  void draw(int startX, int startY){
      stroke(lineColor);
      line(startX, startY, startX + x, startY + y);
  }
  
  void drawPoint(int startX, int startY){
     stroke(pointColor);
     strokeWeight(6);
     point(x +  startX, y + startY);
  }
  
  void setPC(color newpc){
     pointColor = newpc; 
  }
  
  void setTC(color newtc){
     textColor = newtc; 
  }
  
  void setLC(color newlc){
     lineColor = newlc;
  }
  
  void resetColors(){
     pointColor = default_color;
     textColor = default_color;
     lineColor = default_color;  
  }
  
  void setColors(color new_c){
      pointColor = new_c;
      textColor = new_c;
      lineColor = new_c;
  }
}



// --- POINT CLASS ---
//  The point class holds the coordinate for a point.
//  Should I give it a stroke weight parameter?
//
class Point{
 public int x;
 public int y;
 
 Point(int X, int Y){
   x = X;
   y = Y;   
  }
  
  Point(Point old){
   x = old.x;
   y = old.y;
  }
  
  //Draws the point with a stroke of 5.
  void draw(){
   strokeWeight(5);
   point(x,y); 
  }
  
  Point lerpWith(Point p, float amt){
    Point newP = new Point(0,0);
    newP.x = (int)lerp(this.x, p.x, amt);
    newP.y = (int)lerp(this.y, p.y, amt);
    
    return newP;
  }
}