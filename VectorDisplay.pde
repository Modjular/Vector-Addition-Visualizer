//
//  For displaying an interactive UI that lets the user manipluate the vectors
//
class VectorDisplay{
  Vector[] VA;
  
  int topx, topy, ox, oy, minx, miny, maxx, maxy, xbounds, ybounds;
  int selected = -1;
  int previous = -1;
  int detection_radius = 8;
  
  // Constructor
  // Takes an array of vectors, with coords for placing the graph.
  // Note, they are NOT the dimensions; those are determined by the global variables
  // minimum, maximum, and scale
  VectorDisplay(Vector[] va, int x, int y){ 
    VA = va;
    
    topx = x; //Top left corner of the rect
    topy = y;
    
    minx = minimum * scale;  // The min and max of the axis drawn within the rect
    miny = minimum * scale;  // These are all global
    maxx = maximum * scale;
    maxy = maximum * scale;
    
    ox = topx + Math.abs(minx); //The origin of the axis
    oy = topy + Math.abs(miny); //Used for drawing the vectors
    
    xbounds = Math.abs(minx) + Math.abs(maxx); //Basically the length and width
    ybounds = Math.abs(miny) + Math.abs(maxy);
  }
  
  
  
  // State machine, checks for any changes to current vectors
  // Uses boolean stateChanged to flag need for redraw
  public void checkState(){
    
    if(mouseWithinBounds()){
       previous = selected;
       selected = mouseOnPoint();
       if(selected != -1){ //is the mouse is hovering over a point
         VA[selected].setColors(blue);
         stateChanged = true;
         if(mousePressed){  // has the mouse clicked the "selected" point
            VA[selected].setPC(green);
            VA[selected].x = mouseX - ox;
            VA[selected].y = mouseY - oy;
            stateChanged = true;
         }else{             // mouse has not clicked "selected" point
            if(previous != selected){  // we're not on the same point
              stateChanged = true;
            }
            stateChanged = true;
         }
       }else{
           //if mouse hasn't "selected" anything, do something
           stateChanged = true;
       }
    }else{
      //if mouse is not within bounds, do something
    }
  }
  
  public void draw(){
     fill(lavender);
     noStroke();
     rect(topx, topy, xbounds, ybounds);
     
     strokeWeight(1);
     stroke(dark);
     line(topx + Math.abs(minx), topy, topx + Math.abs(minx), topy + ybounds); //y-axis
     line(topx, topy + Math.abs(miny), topx + xbounds, topy + Math.abs(miny)); //x-axis - has to be adjusted for the upside down coord system
     
     drawVectors();
  }
  
  
  // Draws the corresponding vector info (just coords for now)
  private void drawInfo(){
    for(int i = 0; i < VA.length; i++){
         fill(VA[i].textColor);
         String coordText = "V" + (i+1) + ": " + VA[i].x + ", " + VA[i].y;
         text(coordText, topx, topy + ybounds + 24*(i+1));
    }
  }
  
  
  //
  // Draws the interactive display vectors
  //
  private void drawVectors(){
     for(int i = 0; i < VA.length; i++){
         strokeWeight(2);
         VA[i].draw(ox, oy);
         
         if(selected != i){
             VA[i].resetColors(); //resets them all to peppermint
         }
         
         VA[i].drawPoint(ox, oy);
     }
  }
  

  
  

  // --- INTERACTION FUNCTIONS ---

  //
  //  Returns true if you're within the bounds of the vector display
  //
  private boolean mouseWithinBounds(){
     return mouseX > topx && 
            mouseX < topx + xbounds && 
            mouseY > topy && 
            mouseY < topy + ybounds;
  }
  
  //
  //  returns true if the mouse is within the "dot"
  //
  private boolean mouseInRadius(int x, int y, int radius){
    return dist((float)x, (float)y, pmouseX, pmouseY) <= (float)radius;
  }
  
  //
  //  Detects if you're clicking on any of the points in the Vector Display
  //
  private int mouseOnPoint(){
      for(int i = 0; i < VA.length; i++){
        if(mouseInRadius(ox + VA[i].x, oy + VA[i].y, detection_radius)){
          return i;
        }
      }
      
      //if the mouse is not touching any points, return false, reset selected to -1
      return -1;
  }
}