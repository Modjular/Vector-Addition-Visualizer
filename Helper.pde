
//
// Return n random vectors within the min and max
//
Vector[] randomVectors(int numVectors, int min, int max){
  Vector[] newVA = new Vector[numVectors];
  for(int i = 0; i < numVectors; i++){
   newVA[i] = new Vector((int)(random(min,max))* scale, (int)(random(min,max)) * scale); 
  }
  
  return newVA;
}


//
//  Returns n vectors evenly spaced in the first quadrant
//
Vector[] positiveVectors(int num, int length){
   Vector[] newVA = new Vector[num];
   float interval;
   
   if(num > 1){
       interval = HALF_PI/(float)(num - 1);
   }else{
       newVA[0] = new Vector(0, length * scale);
       return newVA;
   }
   
   for(int i = 0; i < num; i++){
       float deg = interval * i;
       float x = length * scale * cos(deg);
       float y = -length * scale * sin(deg);
       println("(X , Y): " + x +  " , " + y);
       newVA[i] = new Vector((int)x, (int)y);
   }
   
   return newVA;
 }
 
 
 //
 // Returns n vectors evenly spaced around the origin
 //
 Vector[] radialVectors(int num, int length){
   Vector[] newVA = new Vector[num];
   float interval;
   
   if(num > 1){
       interval = TWO_PI/(float)num;
   }else{
       newVA[0] = new Vector(0, length * scale);
       return newVA;
   }
   
   for(int i = 0; i < num; i++){
       float deg = interval * i;
       float x = length * scale * cos(deg);
       float y = -length * scale * sin(deg);
       println("(X , Y): " + x +  " , " + y);
       newVA[i] = new Vector((int)x, (int)y);
   }
   
   return newVA;
 }
 
//
// Given a specified angle, between 0 and TWO_PI, 
// returns n evenly spaced vectors
//
Vector[] customRadialVectors(int num, float angle, int length){
   Vector[] newVA = new Vector[num];
   float interval;
   
   if(angle > TWO_PI || angle < 0){
      angle = angle % TWO_PI; 
   }
   
   if(num > 1){
       interval = angle/(float)(num - 1);
   }else{
       newVA[0] = new Vector(0, length * scale);
       return newVA;
   }
   
   for(int i = 0; i < num; i++){
       float deg = interval * i;
       float x = length * scale * cos(deg);
       float y = -length * scale * sin(deg);
       println("(X , Y): " + x +  " , " + y);
       newVA[i] = new Vector((int)x, (int)y);
   }
   
   return newVA;
 }



//
//  Most efficient edge drawing.
//  Takes 2^n nodes, draws less than n nodes from each O(n2^n)
//  2^n+1 because there is a "forward" and "backward" draw per node
//
void evenBetterRender(Vector[] V, int center_x, int center_y){
  int vert_count = (int)pow(2, V.length);
  Vector len = sumVectors(V);

  int start_x = center_x - len.x/2;
  int start_y = center_y - len.y/2;
  
  strokeWeight(1);
  
  for(int i = 0; i < vert_count; i++){
     int x = start_x; // node position, before we add vector magnitudes
     int y = start_y;
     int vert_flags = i;
     
     for(int j = 0; j < V.length; j++){
       if((vert_flags & 1) == 1){
          x += V[j].x;
          y += V[j].y;
       }
       vert_flags >>= 1;
     }
     
     vert_flags = i; //reset
     
     // Is there a way to do this within a single loop?
     for(int j = 0; j < V.length; j++){
       stroke(V[j].lineColor);
       if((vert_flags & 1) == 0){
          line(x, y, x + V[j].x, y + V[j].y); //if 1, draw the preceding node (cur - V[i])
          counter_3++;
      }
       vert_flags >>= 1;
     }
     
  }
}



//
//  More efficient edge drawing.
//  Takes 2^n nodes, draws n nodes from each O(n2^n+1)
//  Credit: Andrew Brockman
//
void betterRender(Vector[] V, int center_x, int center_y){
  int vert_count = (int)pow(2, V.length);
  Vector len = sumVectors(V);

  int start_x = center_x - len.x/2;
  int start_y = center_y - len.y/2;
  
  strokeWeight(1);
  
  for(int i = 0; i < vert_count; i++){
     int x = start_x; // node position, before we add vector magnitudes
     int y = start_y;
     int vert_flags = i;
     
     for(int j = 0; j < V.length; j++){
       if((vert_flags & 1) == 1){
          x += V[j].x;
          y += V[j].y;
       }
       vert_flags >>= 1;
     }
     
     vert_flags = i; //reset
     
     // Is there a way to do this within a single loop?
     for(int j = 0; j < V.length; j++){
       stroke(V[j].lineColor);
       if((vert_flags & 1) == 0){
          line(x, y, x + V[j].x, y + V[j].y); //if 1, draw the preceding node (cur - V[i])
       }else{
          line(x, y, x - V[j].x, y - V[j].y); //else, draw the following node (cur + V[i])
       }
       counter_2++;
       vert_flags >>= 1;
     }
     
  }
}



//
// Recursively render the vector set
// Draw connecting lines
// NOT TERRIBLY EFFICIENT O(n!)
//
void renderVectors(Vector[] V, int centerX, int centerY){
  int lenX = end.x - start.x;
  int lenY = end.y - start.y;
  
  start.x = centerX - lenX/2;
  start.y = centerY - lenY/2;
  setEnd(); //why did I do this
  
  strokeWeight(1);
  drawVectors(V, start.x, start.y);
  //strokeWeight(3);
  //stroke(color(light_blue, 128));
  //line(start.x, start.y, end.x, end.y);
}



//
//  Given an index and starting point, it will recursively draw all permutations
//  The conciseness of recursion!
//
void drawVectors(Vector[] V, int nx, int ny){
  if(V.length == 1){
    V[0].draw(nx, ny);
    counter++;
    return; 
  }
  
  for(int i = 0; i < V.length; i++){
    //line(nx, ny, nx+V[i].x, ny+V[i].y);
    V[i].draw(nx, ny);
    counter++;
    drawVectors(truncate(V, i), nx+V[i].x, ny+V[i].y);
  }
  
}



//
//  Takes an index to truncate, returns a shortened array. 
//  Helper function for drawVectors()
//
Vector[] truncate(Vector[] V, int indexToCut){
  Vector[] newV = new Vector[V.length - 1];
  
  int count = 0;
  int i = 0;
  while(count < V.length){
    if(count != indexToCut){
      newV[i] = new Vector(V[count]);
      i++;
    }
    count++;
  }
  return newV;
}


//This needs to be changed
void setEnd(){
   end = new Point(start); 
   
   for(int i = 0; i < vectors.length; i++){
      end.x += vectors[i].x;
      end.y += vectors[i].y;
   }
}

// Returns the sum of a vector array
Vector sumVectors(Vector[] V){
   Vector sum = new Vector(0,0);
   for (Vector v : V){
      sum.add(v);
   }   
   return sum;
}


// For displaying the draw counts of each render method
void drawDebug(){
    fill(red);
    text("renderVectors() draw-count: " + counter, 100, 400);
    text("evenBetterRender() draw-count: " + counter_3, 100, 730);
    counter = 0;
    counter_2 = 0;
    counter_3 = 0;
}