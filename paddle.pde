/*
This class contains the required function 
for drawing and moving the paddle object.
*/

class paddle {

  int paddleMidX = 320; //initial paddle X in middle
  int paddleWidth = 100; //initial paddle Y

  boolean leftPress = false; //boolean set to true if left key pressed
  boolean rightPress = false; //boolean set to true if left key pressed

  void drawPaddle() {
    rectMode(CENTER); //paddle is drawn from centre, rather than corner
    strokeWeight(2);
    stroke(#FF00FB);
    fill(255);
    rect(paddleMidX, 400, paddleWidth, 10, 5);
  }  

  void movePaddle() { //moves paddle 5 pixels left/right, if inside the play field
    if (leftPress == true  && paddleMidX-(paddleWidth/2) > 0) {
      paddleMidX -= 5;
    }
    if (rightPress == true && paddleMidX+(paddleWidth/2) < width) {
      paddleMidX += 5;
    }
  }
  
} //End of Class

