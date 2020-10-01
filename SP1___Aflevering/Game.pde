import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private Keys2 keys2;
  private int playerLife;
  private int playerLife2;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] food;
  
   
  Game(int width, int height, int numberOfEnemies, int numberOfFood)
  {
    if(width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if(numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    keys2= new Keys2(); //initializing keys 2
    player = new Dot(0,0,width-1, height-1);
    player2 = new Dot(24,0,width -1, height-1); // setting coordinates for player 2 and initializing
    food = new Dot[numberOfFood];
    for(int i = 0; i < numberOfFood; i++)
    {
      food[i] = new Dot(width-1, height-1, width -1, height -1);
    }
    enemies = new Dot[numberOfEnemies];
    for(int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.playerLife = 100;
    this.playerLife2 = 100; // setting player 2 life to 100
  }
  
  public int getWidth()
  {
    return width;
  }
  
  public int getHeight()
  {
    return height;
  }
  
  public int getPlayerLife()
  {
    return playerLife;
  }
  //player 2's life
  public int getPlayerLife2()
  {
    return playerLife2;
  }
  
  
  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }
  
  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }
  //new keypressed for player 2
  public void onKeypressed2()
  {
    keys2.onKeyPressed2();
  }
  //new keyreleased for player 2
  public void onKeyReleased2()
  {
    keys2.onKeyReleased2();
  }
  
  
  public void update()
  {
    updatePlayer2();
    updatePlayer();
    updateEnemies();
    updateFood();
    checkForCollisions();
    checkForCollisions2();
    clearBoard();
    populateBoard();
    populateBoard2();
    populateBoard3();
    
  }
  
  
  
  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }
  
  private void clearBoard()
  {
    for(int y = 0; y < height; ++y)
    {
      for(int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }
  
  private void updatePlayer()
  {
    //Update player
    if(keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if(keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if(keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if(keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }
  
  private void updatePlayer2()
  {
    //Update player
    if(keys2.upDown() && !keys2.downDown())
    {
      player2.moveUp();
    }
    if(keys2.leftDown() && !keys2.rightDown())
    {
      player2.moveLeft();
    }
    if(keys2.downDown() && !keys2.upDown())
    {
      player2.moveDown();
    }
    if(keys2.rightDown() && !keys2.leftDown())
    {
      player2.moveRight();
    }
  }
  
  private void updateEnemies()
  {
    int dx;
    int dy;
    for(int i = 0; i < enemies.length-1; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if(rnd.nextInt(3) < 2)
      {
        if((player.getX() - enemies[i].getX()) + (player.getY() - enemies[i].getY()) < (player2.getX() - enemies[i].getX()) + (player2.getY() - enemies[i].getY()))
        {
          //We follow player 1 
          dx = player.getX() - enemies[i].getX();
          dy = player.getY() - enemies[i].getY();
        }
          else
        { // we follow player 2 
          dx = player2.getX() - enemies[i].getX();
          dy = player2.getY() - enemies[i].getY();
        }
          
        
        if(abs(dx) > abs(dy))
        {
          if(dx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          }
          else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        }
        else if(dy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        }
        else
        {//Player is up;
          enemies[i].moveUp();
        }
      }
      else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if(move == 0)
        {
          //Move right
          enemies[i].moveRight();
        }
        else if(move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        }
        else if(move == 2)
        {
          //Move up
          enemies[i].moveUp();
        }
        else if(move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }
  
  private void updateFood()
  {
    int dx;
    int dy;
    for(int i = 0; i < food.length-1; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if(rnd.nextInt(3) < 2)
      {
        if((player.getX() + food[i].getX()) - (player.getY() + food[i].getY()) < (player2.getX() + food[i].getX()) - (player2.getY() + food[i].getY()))
        {
          //We move away player 1 
          dx = player.getX() + food[i].getX();
          dy = player.getY() + food[i].getY();
        }
          else
        { // we move away player 2 
          dx = player2.getX() + food[i].getX();
          dy = player2.getY() + food[i].getY();
        }
          
        
        if(abs(dx) > abs(dy))
        {
          if(dx > 0)
          {
            //Player is to the right
            food[i].moveLeft();
          }
          else
          {
            //Player is to the left
            food[i].moveRight();
          }
        }
        else if(dy > 0)
        {
          //Player is down;
          food[i].moveUp();
        }
        else
        {//Player is up;
          food[i].moveDown();
        }
      }
      else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if(move == 0)
        {
          //Move right
          food[i].moveRight();
        }
        else if(move == 1)
        {
          //Move left
          food[i].moveLeft();
        }
        else if(move == 2)
        {
          //Move up
          food[i].moveUp();
        }
        else if(move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }
  
  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1;
    //Insert enemies
    for(int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
  }
  
  private void populateBoard2() //DISPLAY PLAYER 2 AND GIVE HIM/HER THE COLOR YELLOW
  {
    //Insert player
    board[player2.getX()][player2.getY()] = 4;
  }
  
  
  private void populateBoard3()
  {
    for (int i = 0; i < food.length; i++)
    {
      board[food[i].getX()][enemies[i].getY()] = 3;
    }
  }
    
   
  private void checkForCollisions()
  {
    //Check enemy collisions
    for(int i = 0; i < enemies.length; ++i)
    {
      if(enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
        

      }
     else if(enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY()) // CHECKING FOR COLLISION FOR PLAYER 2
     {
       --playerLife2;
     }
    }
  }
  
  private void checkForCollisions2() //Get life when collisions is made
  {
    for (int i = 0; i < food.length; i++)
    {
      if(food[i].getX() == player.getX() && food[i].getY() == player.getY())
      {
        playerLife = playerLife +5;
      }
      else if(food[i].getX() == player2.getX() && food[i].getY() == player2.getY())
      {
        playerLife2 = playerLife2 +5;
      }
    }
  } 
}
