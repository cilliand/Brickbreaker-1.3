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
