/*
This class contains the required function 
 for drawing the ball object, including it's 
 collisions with walls, paddle, bricks, blocks 
 and prizes.
 */
class ball {


  //variable declarations of ball
  float posX = 320;
  float posY = 388;

  float speedX = 0;
  float speedY = 0;

  float ballr = 10; 

  boolean serve, moving, speedy, fireballed = false;



  void drawBall() {      
    if (fireballed) { //use different style when fireball prize is collected
      stroke(255, 0, 0);
      strokeWeight(3);
      fill(#FF8E03);
    }
    else { //if not fireball prize, style as normal ball
      noStroke();   
      fill(255);
    }
    
    if(!fireballed){
    ellipse(posX, posY, ballr, ballr);
    }else{
    ellipse(posX, posY, ballr*1.5, ballr);
    }
    
    if (serve == true) { //if space has been pressed
      speedX = 0.25; //set inital X speed
      speedY = -2; //set default Y speed
      serve = false; //reset serve to false
    }

    if (serve == false && moving == false) { //ball should move with paddle if it has not been served yet
      posX = paddle.paddleMidX;
    }
  } 

  void moveBall() {
    if (speedy == false) { //if speedup prize not collected move at normal speed
      posX += speedX;
      posY += speedY;
    } 
    else { //if speedup prize is collectied move faster
      posX += speedX;
      posY += speedY*1.5;
    }
  }

  //check collision with normal brick
  //(brick array to check, number of columns in array, number of rows, startX and startY of bricks)  
  void collision(boolean s[][], int cols, int rows, int startX, int startY) {
    //loops through 2d array
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (s[i][j] && posX + ballr >= startX+(40*i) //If the ball's right side is past the left side of the brick
        && posX - ballr <= startX+(40*i)+38 //If the ball's left side is past the right side of the brick
        && posY + ballr >= startY+(20*j) //If the ball's bottom is past the top of the brick
        && posY - ballr <= startY+18+(20*j)) { //If the ball's top is above the bottom of the brick

          if ((posX < startX+(40*i) && speedX > 0 && !fireballed) //If the ball hits the left side of the brick
          || (posX > startX+(40*i)+38 && speedX < 0) && !fireballed) { //Or if the ball hits the right side of the brick
            speedX = -speedX; // reflect it back
          }
          if ((posY <  startY+(20*j) && speedY > 0 && !fireballed) //If the ball hits the top side of the brick
          || (posY > startY+18+(20*j) && speedY < 0) && !fireballed) { ///Or the ball hits the bottom of the brick,
            speedY = -speedY; // reflect the ball vertically
          }     

          player1.play(); //play hit sound
          level.score++; //increase score
          player1.rewind(); //rewine player
          s[i][j] = false; //set array position to false, brick not shown

          //set posX, posY for prizes to the balls posX, posY (if needed) - checks are within prize itself.
          grow.posX[i] = posX;
          grow.posY[i] = posY;
          fireball.posX[i] = posX;
          fireball.posY[i] = posY;
          speedup.posX[i] = posX;
          speedup.posY[i] = posY;
           
        }
      }
    }
  }

  //check collision with block - requires two hits to remove
  //(block array to check, number of colunms in array, number of rows, startX and startY of blocks)  
  void collisionBlock(int s[][], int cols, int rows, int startX, int startY) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (s[i][j] < 2 && posX + ballr >= startX+(40*i) //If the ball's right side is past the left side of the brick
        && posX - ballr <= startX+(40*i)+38 //If the ball's left side is past the right side of the brick
        && posY + ballr >= startY+(20*j) //If the ball's bottom is past the top of the brick
        && posY - ballr <= startY+18+(20*j)) { //If the ball's top is above the bottom of the brick

          if ((posX < startX+(40*i) && speedX > 0) //If the ball hits the left side of the brick
          || (posX > startX+(40*i)+38 && speedX < 0)) { //Or if the ball hits the right side of the brick,
            speedX = -speedX; //reflect it back
          } 
          if ((posY < startY+(20*j) && speedY > 0) //If the ball hits the top side of the brick
          || (posY > startY+18+(20*j) && speedY < 0)) { //Or the ball hits the bottom of the brick, 
            speedY = -speedY; //reflect the ball vertically
          }

          //check for collision with block
          player1.play();
          s[i][j] ++; //number of hits at this array position should be increased
          player1.rewind();
        }
      }
    }
  }



  /* Checks to see if a prize has hit the paddle */
  void collisionGrow() {
    for (int i = 0; i < 16; i++) {
      if (grow.posY[i] >= 380 && grow.posY[i] < 400 && grow.posX[i] >= paddle.paddleMidX-(paddle.paddleWidth/2) && grow.posX[i] <= paddle.paddleMidX+(paddle.paddleWidth/2)
        && grow.posX[i] >= 0 && grow.posX[i] <= width) {
        grow.gotPrize = true;
        grow.timer = 900; //set timer
        grow.posY[i] = -180; //remove prize from screen
        grow.posX[i] = -180; //remove prize from screen
      }
    }
  }

  void collisionSpeed() {
    for (int i = 0; i < 16; i++) {
      if (speedup.posY[i] >= 380 && speedup.posY[i] < 400 && speedup.posX[i] >= paddle.paddleMidX-(paddle.paddleWidth/2) && speedup.posX[i] <= paddle.paddleMidX+(paddle.paddleWidth/2)
        && speedup.posX[i] >= 0 && speedup.posX[i] <= width) {
        speedup.gotPrize = true;
        speedup.timer = 900; //set timer
        speedup.posY[i] = -180; //remove prize from screen
        speedup.posX[i] = -180; //remove prize from screen
      }
    }
  }

  void collisionFireBall() {
    for (int i = 0; i < 16; i++) {
      if (fireball.posY[i] >= 380 && fireball.posY[i] < 400 && fireball.posX[i] >= paddle.paddleMidX-(paddle.paddleWidth/2) && fireball.posX[i] <= paddle.paddleMidX+(paddle.paddleWidth/2)
        && fireball.posX[i] >= 0 && fireball.posX[i] <= width) {
        fireball.gotPrize = true; 
        fireball.timer = 900; //set timer
        fireball.posY[i] = -180; //remove prize from screen
        fireball.posX[i] = -180; //remove prize from screen
      }
    }
  }
  /*End of checks to see if prize has hit a paddle*/

  /*Start of checks to see if ball has collded with paddle or walls*/
  void collisionPaddleWall() {
    //Check left and right sides
    if (posX <= 0+ballr || posX >= width-ballr) {
      speedX *= -1;
    }
    //Check top of screen
    if (posY <= 0+ ballr) {
      speedY *= -1;
    }


    //Collision of the ball with the paddle - adapted from source at http://www.openprocessing.org/sketch/50736 
    if (posX + ballr > paddle.paddleMidX-(paddle.paddleWidth/2) //If the ball is right of the left side of the paddle
    && posX - ballr < paddle.paddleMidX+(paddle.paddleWidth/2) //If the ball is on the left of the right side of the paddle
    && posY + ballr > 400 //If the ball is past the top of the paddle
    && posY + ballr < 400 + 10 //If the ball is above the bottom of the paddle
    && speedY > 0) { //If the ball is moving downwards (as to stop a glitch which causes the ball to vibrate when bouncing off the paddle)
      if (posX > paddle.paddleMidX) { //If the ball hits on the right side of the paddle
        speedX = dist(paddle.paddleMidX, 0, posX, 0)/25;//HORIZANTAL_SPEED_SENSITIVITY; //Angle towards the right side in proportion to the distance of the ball with the middle of the paddle
      }
      else { //If the ball hits on the left side of the paddle
        speedX = -dist(paddle.paddleMidX, 0, posX, 0)/25;//HORIZANTAL_SPEED_SENSITIVITY; //Angle towards the left side in proportion to the distance of the ball with the middle of the paddle
      }
      speedY = -speedY; //Reflect the ball vertically
      player2.play();
      player2.rewind();
    }




    //Check if paddle has gone off the bottom of the screen
    if (posY > height) {
      posX = paddle.paddleMidX;
      posY = 388;
      speedX = 0;
      speedY = 0;  
      moving = false; //ball is set not to move
      if (level.lives > 0) {
        level.lives--; //if player has lives remove one
      }
      else {
        level.gameOver = true; //if player has no lives, then game is over
      }
    }
  }  /*End of checks to see if ball has collded with paddle or walls*/
  

} //End of Class

