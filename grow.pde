/*
This class contains the required function 
for deliver and drawing the grow prize object. 

This prize prize increased the paddles width to 150.
*/

class grow {
  
  int[] prizes = new int[16]; //array containing whether position will have a prize (set in brick class)
  
  boolean gotPrize = false;
  
  int timer;  //timer to remove prize after set amount of timer
  
  //arrays containing X and Y position of the prize ball - allowing it to move down the screen.
  float[] posX = new float[16];
  float[] posY = new float[16];

  void prize() { //draws the prize balls and moves down the screen
    for (int i = 0; i < 16; i++) {
         if (prizes[i] == 1) {
          fill(0, 255, 0);
          stroke(0, 255, 0);
          ellipse(posX[i], posY[i], 15, 15);
          posY[i] += 0.75;
        }
      }
    }
  

  void doPrize() {
    if (gotPrize == true && timer > 0) {  //if player's paddle catches the prize and has times left
      if(paddle.paddleWidth < 150)
      paddle.paddleWidth++;
     // paddle.paddleWidth = 150; //paddle with is set to 150
     timer --; //timer counts down
    }
    else {
      if(paddle.paddleWidth > 100)
      paddle.paddleWidth--;
      //paddle.paddleWidth = 100; //when out of time, paddle width reverts to 100.
    }
  }
  
  
}

