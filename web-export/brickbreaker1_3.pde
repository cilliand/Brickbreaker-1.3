//create brick objects
bricks brick1 = new bricks();
bricks brick2 = new bricks();
bricks brick3 = new bricks();

//create block object (requires two hits to remove)
blocks block1 = new blocks();



//create new ball object
ball ball = new ball();
//create new ball object
paddle paddle = new paddle();
//create new level information object
level level = new level();
//create new prize objects
grow grow = new grow();
speedup speedup = new speedup();
fireball fireball = new fireball();

boolean start = true; //variable to check levels
boolean level1complete, level2complete, level3complete, level4complete, level5complete = false; //variable to check levels completed

//Audio objects
import ddf.minim.*;
AudioPlayer player1, player2;
Minim minim;

//Font object
PFont font;


void setup() {
   size(640, 480); //set up display size
   
  level.introBg = loadImage("wall.jpg"); //load background image into object - (http://www.flickr.com/photos/coun2rparts/3508864575/sizes/z/in/photostream/ - Creative Commons License Some rights reserved by coun2rparts)
   
   //Set up initial brick objects, further calls within levels.
   brick1.setup(true);
   brick2.setup(true);
   brick3.setup(true);
 
  //Set up Font
  font = loadFont("Chalkduster-20.vlw"); 
  
  //Set up Audio Objects  
  minim = new Minim(this);
  player1 = minim.loadFile("bounce.wav", 2048);
  player2 = minim.loadFile("woodbounce.wav", 2048);
}

void draw() {
  smooth();
  background(0);
  if (level.gameComplete == true) {
    level.gameComplete(); //Show winning screen if game completed
  }
  if (level.gameOver == true) {
    level.gameOver(); //Show game over screen if all lives lost
  }
  if (level.intro == true) {
    level.intro(); //show intro screen at start of game.
  } 
  else {
  
    //code to arrange levels sorting  
    if(start && !level1complete) //check start and that level 1 has not been completed (prevents overlapping bricks)
    level1(); //call level 1
    
    if(level1complete && !level2complete) //check level 1 is complete and that level 2 has not been completed (prevents overlapping bricks)
    level2(); //call level 2
    
    if(level2complete && !level3complete) //check level 2 is complete and that level 3 has not been completed (prevents overlapping bricks)
    level3(); //call level 3
    
    if(level3complete && !level4complete) //check level 3 is complete and that level 4 has not been completed (prevents overlapping bricks)
    level4(); //call level 4
    if(level4complete && !level5complete) //check level 4 is complete and that level 5 has not been completed (prevents overlapping bricks)
    level5(); //call level 5
    //end of code to arrange level sorting.
      
     
    //start of ball animation  
    ball.drawBall();
    ball.moveBall();
    //end of ball animation
    
    //start of collision detection
    ball.collisionPaddleWall();
    ball.collisionGrow();
    ball.collisionSpeed();
    ball.collisionFireBall();
    //end of collision detection
    
    //start of paddle animation
    paddle.drawPaddle();
    paddle.movePaddle();
    //end of paddle animation
    
    level.levelInfo(); // display level informartion

    //Prize calls
    grow.prize(); //checks if prize is valid (i.e. array contains '1' at that position)
    grow.doPrize(); //if it is update variables related to that prize.
    speedup.prize(); //checks if prize is valid (i.e. array contains '1' at that position)
    speedup.doPrize(); //if it is update variables related to that prize.
    fireball.prize(); //checks if prize is valid (i.e. array contains '1' at that position)
    fireball.doPrize(); //if it is update variables related to that prize.
    //End of Prize Calls
    
  }
}

void keyPressed() {
  //code to move paddle
  if (keyCode == LEFT) {
    paddle.leftPress = true;
  }
  if (keyCode == RIGHT) {
    paddle.rightPress = true;
  }
  //Press ENTER to start game/remove intro screen
  if (keyCode == ENTER) {
    level.intro = false;
  }
  
  //if all lives are gone, R will reset the game
  if (key == 'R' || key == 'r' && level.gameOver == true) {
    level.intro = true;
    level.gameOver = false;
    start = true;
    level1complete = false;
    level2complete = false;
    level3complete = false;
    level4complete = false;
  }

  //SPACE BAR sets ball moving, if not at intro and not all lives lost
  if (key == ' ' && ball.moving == false && level.intro == false && level.gameOver == false) {
    ball.serve = true;
    ball.moving = true;
  } 
  
    
}

void keyReleased() {
  //code to move paddle
  if (keyCode == LEFT) {
    paddle.leftPress = false;
  }
  if (keyCode == RIGHT) {
    paddle.rightPress = false;
  }
} 

//levels

void level1(){
    
    brick1.drawBricks(10, 2, 120, 0, #FF0000);
    ball.collision(brick1.brickOn, 10, 2, 120, 0);
    
    brick2.drawBricks(8, 1, 160, 40, #FFF700);
    ball.collision(brick2.brickOn, 8, 1, 160, 40);    
    
    brick3.drawBricks(6, 2, 200, 60, #00FF00);
    ball.collision(brick3.brickOn, 6, 2, 200, 60);
    
    //level cleared
    if(level.score >= 0){ //tptal number of bricks
      //reset ball
      ball.posX = paddle.paddleMidX;
      ball.posY = 388;
      ball.speedX = 0;
      ball.speedY = 0; 
      ball.moving = false;
      //reset level conditions
      level.score = 0;
      level1complete = true;
      level.levelNum = 2;
      start = false;   
      brick1.setup(true);
      brick2.setup(true);
      brick3.setup(true);
    }
    
}
   


void level2(){
    brick1.drawBricks(16, 2, 0, 0, #FF0000);
    ball.collision(brick1.brickOn, 16, 2, 0, 0);
    
    brick2.drawBricks(8, 1, 160, 60, #FFF700);
    ball.collision(brick2.brickOn, 8, 1, 160, 60);    
    
    brick3.drawBricks(6, 1, 200, 80, #00FF00);
    ball.collision(brick3.brickOn, 6, 1, 200, 80);
    
    //level cleared
    if(level.score >= 0){ //tptal number of bricks
      //reset ball
      ball.posX = paddle.paddleMidX;
      ball.posY = 388;
      ball.speedX = 0;
      ball.speedY = 0; 
      ball.moving = false;
      //reset level conditions
      level.score = 0;
      level2complete = true;
      level.levelNum = 3;
      start = false;   
      brick1.setup(true);
      brick2.setup(true);
      brick3.setup(true);
      block1.setup(0);
    }
}


void level3(){
    
    brick1.drawBricks(16, 2, 0, 0, #FF0000);
    ball.collision(brick1.brickOn, 16, 2, 0, 0);
    
    brick2.drawBricks(8, 2, 160, 60, #FFF700);
    ball.collision(brick2.brickOn, 8, 2, 160, 60);    
    
    brick3.drawBricks(6, 2, 200, 120, #00FF00);
    ball.collision(brick3.brickOn, 6, 2, 200, 120);
    
    block1.drawBlocks(16, 1, 0, 200);
    ball.collisionBlock(block1.blockHit, 16, 1, 0, 200);
    
    
    //level cleared
    if(level.score>= 10){ //total number of bricks
      //reset ball
      ball.posX = paddle.paddleMidX;
      ball.posY = 388;
      ball.speedX = 0;
      ball.speedY = 0; 
      ball.moving = false;
      //reset level conditions
      level.score = 0;
      level3complete = true;
      level.levelNum = 4;
      start = false;   
      brick1.setup(true);
      brick2.setup(true);
      brick3.setup(true);
      block1.setup(0);
  }
}

void level4(){
    
    brick1.drawBricks(16, 4, 0, 0, #FFAE4B);
    ball.collision(brick1.brickOn, 16, 4, 0, 0);
    
    brick2.drawBricks(16, 4, 0, 80, #FFF700);
    ball.collision(brick2.brickOn, 16, 4, 0, 80);    
    
    block1.drawBlocks(16, 1, 0, 160);
    ball.collisionBlock(block1.blockHit, 16, 1, 0, 160);
    
    brick3.drawBricks(16, 2, 0, 180, #596BFC);
    ball.collision(brick3.brickOn, 16, 2, 0, 180);
       
    //level cleared
    if(level.score >= 10){ //total number of bricks
      //reset ball
      ball.posX = paddle.paddleMidX;
      ball.posY = 388;
      ball.speedX = 0;
      ball.speedY = 0; 
      ball.moving = false;
      //reset level conditions
      level.score = 0;
      level4complete = true;
      level.levelNum = 5;
      start = false;   
      brick1.setup(true);
      brick2.setup(true);
      brick3.setup(true);
      block1.setup(2);
    }
}

void level5(){
    
    brick1.drawBricks(4, 4, 240, 0, #898DFF);
    ball.collision(brick1.brickOn, 4, 4, 240, 0);
    
    brick2.drawBricks(12, 4, 80, 80, #FFF700);
    ball.collision(brick2.brickOn, 12, 4, 80, 80);    
    
   
   brick3.drawBricks(4, 4, 240, 160, #898DFF);
   ball.collision(brick3.brickOn, 4, 4, 240, 160);
       
    //level cleared
    if(level.score == 42){ //total number of bricks
      //reset ball
      ball.posX = paddle.paddleMidX;
      ball.posY = 388;
      ball.speedX = 0;
      ball.speedY = 0; 
      ball.moving = false;
      //reset level conditions
      level.score = 0;
      level.gameComplete = true;
      level5complete = true;
      level.levelNum = 5;
      start = false;   
      brick1.setup(true);
      brick2.setup(true);
      brick3.setup(true);
    }
}
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

/*
This class contains the required function 
for deliver and drawing the fireball prize object. 

This prize allows the ball to move through bricks (but not blocks), bouncing only off walls and blocks.
*/

class fireball {

  int[]prizes = new int[16]; //array containing whether position will have a prize (set in brick class)
  
  boolean gotPrize = false;
  
  int timer;  //timer to remove prize after set amount of timer
  
  //arrays containing X and Y position of the prize ball - allowing it to move down the screen.
  float[] posX = new float[16];
  float[] posY = new float[16];

  void prize() { //draws the prize balls and moves down the screen
    for (int i = 0; i < 16; i++) {
        if (prizes[i] == 1) {
          fill(#FF8E03);
          stroke(#FF8E03);
          ellipse(posX[i], posY[i], 15, 15);
          posY[i] += 0.75;
      }
    }
  }
 


  void doPrize() {
    if (gotPrize == true && timer > 0) { //if player's paddle catches the prize and has times left
      ball.fireballed = true; //required variable to initiate prize is set
      timer --; //timer counts down
       }
    else {
      ball.fireballed = false; //when out of time, revert to normal status (without prize)
    }  
  }
} //End of class.

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

/*
This class contains the required function 
for level information, intro screen, gameover screen, etc.
*/

class level {

  int levelNum = 1; 
  int score = 0;
  int lives = 2;
  boolean gameOver = false;
  boolean intro = true;
  boolean gameComplete = false;
  
  PImage introBg; //create object for background image of intro screen


  void levelInfo() { //level information (score, level number, lives)
    fill(255);
    textFont(font);
    text("Score: "+score, 10, 450);
    text("Lives: "+lives, 550, 450);  
    text("Level: "+levelNum, 280, 450);
  }

  void gameOver() { //Game Over Screen
    fill(255);
    textFont(font);
    text("Game Over - Press R to Reset", 230, 225);
  } 

  void gameComplete() { //Game Completed Screen
    fill(255);
    textFont(font);
    //background(introBg);
    text("Game Completed", 180, 100);
  } 



  void intro() { //Intro Screen
    
    //background(introBg);
    noStroke();
    fill(255);
    textFont(font);
    text("Welcome to BrickBreaker", 180, 100);
    text("Press ENTER to begin.", 190, 150);
    
    text("Use left and right arrows to move the paddle.", 50, 250);
    text("Collect prizes for power ups:", 50, 270);
    fill(255, 0, 0);
    ellipse(50, 295, 15, 15);
    fill(255);
    text("Increases speed", 65, 300);
    
    fill(0, 255, 0);
    ellipse(50, 320, 15, 15);
    fill(255);
    text("Increases paddle width", 65, 325);
    
    fill(#FF8E03);
    ellipse(50, 345, 15, 15);
    fill(255);
    text("Ball moves through bricks (but not blocks)", 65, 350);
    
    
  }
  
} //End of Class

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


