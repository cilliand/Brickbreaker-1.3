/*
This class contains the required functions 
for drawing the brick object, which requires
one hits to be removed from the playing area.
*/

class bricks {

  int cols = 16;
  int rows = 10;
  int startX = 0;
  int startY = 0;

  int countBreak = 0;
  int prizeNum;

  boolean[][] brickOn = new boolean[16][10];  //each object contains it's own array which is roughly no bigger than play area.
  
     //setup(true/false) - true = brick on, false = brick off 
  void setup(boolean on) { //set up arrays that bricks relate to (bricks & prizes)
 
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        brickOn[i][j] = on; //set each element of array to true/false
      }
    }
     
   for (int i = 0; i < 16; i++) {
        grow.prizes[i] = (int)random(0,2); //set each element of the grow prize array to a random number between 0 and the number of bricks
        fireball.prizes[i] = (int)random(0, 2); //set each element of the fireball prize array to a random number between 0 and the number of bricks
        speedup.prizes[i] = (int)random(0, 2); //set each element of the speedup prize array to a random number between 0 and the number of bricks
    }  


    for (int i = 0; i < 16; i++) {
      grow.posX[i] = -180; //set prize objects offscreen
      grow.posY[i] = -180; //set prize objects offscreen
      grow.gotPrize = false; //set that it has not collided with paddle
      
      speedup.posX[i] = -180; //set prize objects offscreen
      speedup.posY[i] = -180; //set prize objects offscreen
      speedup.gotPrize = false; //set that it has not collided with paddle
      
      fireball.posX[i] = -180; //set prize objects offscreen
      fireball.posY[i] = -180; //set prize objects offscreen
      fireball.gotPrize = false; //set that it has not collided with paddle
    } 

 
   //attempt to remove positions in arrays which contains more than one valid prize (i.e. no element should be 1 in more than one array)      
    for (int i = 0; i < 16; i++) { //remove prizes where it would result in a brick releasing two prizes
        if (speedup.prizes[i] == 1 && grow.prizes[i] == 1) {
          speedup.prizes[i] = 0;
          grow.prizes[i] = 0;
        }
       if(speedup.prizes[i] == 1 && fireball.prizes[i] == 1){ 
          fireball.prizes[i]  = 0;
          speedup.prizes[i] = 0;
        }
      if(grow.prizes[i] == 1 && fireball.prizes[i] == 1){
           grow.prizes[i] = 0;
           fireball.prizes[i]  = 0;
        }  
      }
  }
  



  //draw bricks (no. of cols, no. of rows, startX position, startY position, colour of bricks)
  void drawBricks(int tempcols, int temprows, int tempStartX, int tempStartY, color c) {
    //Set public (to this class) variables to temp. variables
    cols = tempcols;
    rows = temprows;
    startX = tempStartX;
    startY = tempStartY;

    //Loops through array.
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (brickOn[i][j]) { //if brick on is true
          fill(c); //fill with desired color
        } 
        else {
          fill(0, 0, 0); //if element is false draw in black
        }
        stroke(0);
        strokeWeight(1);
        rectMode(CORNER);
        rect(startX+(40*i), startY+(20*j), 38, 18); //draw sqaure, increment it's x and y based on position in the array
      }
    }
  } //End of draw bricks.


} //End of class

