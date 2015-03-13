/*
This class contains the required functions 
for drawing the block object, which requires
two hits to be removed from the playing area.
*/
class blocks {

  int cols = 16;
  int rows = 2;
  int startX = 0;
  int startY = 0;

  int countBreak = 0;

  int[][] blockHit = new int[16][10]; //each object contains it's own array which is roughly no bigger than play area.
  

  void setup(int num) { //array object with initial hit count (0 - on (requires two hits), 1 - requires one hit, 2 - off (no hits) )
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        blockHit[i][j] = num;
      }
    }

  }

  /*Start of function to draw blocks*/
     //drawblocks(no. of cols, no. of rows,  startX position, startY position)
  void drawBlocks(int tempcols, int temprows, int tempStartX, int tempStartY) {
    //Set public (to this class) variables to temp. variables
    cols = tempcols; 
    rows = temprows;
    startX = tempStartX;
    startY = tempStartY;

    //Loops through array.
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (blockHit[i][j] == 0) { //if not hit
          stroke(0); //black border
          fill(#767676); //grey fills   
        }else if (blockHit[i][j] == 1) { //if hit onces
          stroke(255); //white border
          fill(#767676); //grey fills     
        } 
        else { //block removed
          stroke(0); //black border
          fill(0, 0, 0); //black fill
        }
        strokeWeight(1);
        rectMode(CORNER);
        rect(startX+(40*i), startY+(20*j), 38, 18); //draw rectange (block), increment it's x and y based on position in the array
      }
    }
  }/*End of function to draw blocks*/


}/*End of class*/

