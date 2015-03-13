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

