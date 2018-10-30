// Vector Addition Permutator Analyzer (VAPA haha)  //<>// //<>//
// Tony Reksoatmodjo 
// 1/12/17 - 6/24/18
//
// A little sketch that draws all the possible permutations of a given set of vectors.
// It illustrates the commutative property of vector addition, and also looks really
// cool.


int numVecs = 5;     //Number of vectors. Resulting # perms = n!
Vector vectors[];    //Array that holds the vectors
VectorDisplay VD;    //The UI that lets the user manipulate vector length

int counter = 0;    // Just for debug purposes
int counter_2 = 0;
int counter_3 = 0;

int minimum = -10; //min & max vector variance
int maximum = 10;
int lineSize = 2; // thickness of the lines
int scale = 8;   // scale of the graph and vectors
int line_transparency = 127;

boolean stateChanged = true;

Point start = new Point(100, 100);
Point end;

void setup() {
  fullScreen();
  frameRate(22);
  background(dark);

  //vectors = randomVectors(numVecs, minimum, maximum);
  //vectors = positiveVectors(numVecs, maximum);
  vectors = radialVectors(numVecs, maximum);
  //vectors = customRadialVectors(numVecs, (2 * PI) / 3, maximum);
  
  setEnd(); //Only need to do this once; is updated within renderVectors
  
  textSize(16);
  
  VD = new VectorDisplay(vectors, width - 200, 16);
  VD.draw();
}


//
//  The all important Draw Function
//
void draw() {

   
  if(stateChanged){
    background(dark); 
    evenBetterRender(vectors, width/2, height/2); 
    //renderVectors(vectors, width/2, height/2 - 100);
    VD.drawInfo();
    VD.draw();
    drawDebug();
    
    stateChanged = false;
  }
  
    
  VD.checkState(); 
  
  //debug
  //fill(red);
  //text("stateChanged: " + stateChanged, 16, 32);
}

void keyReleased()
{
  println("KEY: " + key);
  if(key == 61 && numVecs < 10){
    numVecs++;
    vectors = radialVectors(numVecs, maximum);
    VD = new VectorDisplay(vectors, width - 200, 16);
    stateChanged = true;
    return;
  }
  
  if(key == 45 && numVecs > 2){
    numVecs--;
    vectors = radialVectors(numVecs, maximum);
    VD = new VectorDisplay(vectors, width - 200, 16);
    stateChanged = true;
    return;
  }
}
