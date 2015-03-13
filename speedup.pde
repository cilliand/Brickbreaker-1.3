/*
This class contains the required function 
for delivering and drawing the speedup prize object. 

This prize prize increased the balls speed 1.5 times.
*/


class speedup {
  int[] prizes = new int[16];  //array containing whether position will have a prize (set in brick class)
  
  boolean gotPrize = false;
  
  int timer; //timer to remove prize after set amount of timer
  
  //arrays containing X and Y position of the prize ball - allowing it to move down the screen.
  float[] posX = new float[16];
  float[] posY = new float[16];

  void prize() { //draws the prize balls and moves down the screen
    for (int i = 0; i < 16; i++) {
        if (prizes[i] == 1) {
          fill(255, 0, 0);
          stroke(255, 0, 0);
          ellipse(posX[i], posY[i], 15, 15);
          posY[i] += 0.75;
        }
      }
    }




  void doPrize() {

    if (gotPrize == true && timer > 0) { //if player's paddle catches the prize and has times left
      ball.speedy = true; //required variable to initiate prize is set
      timer --; //timer counts down
    }
    else {
      ball.speedy = false; //when out of time, revert to normal speed (without prize)
    }
  }
}

