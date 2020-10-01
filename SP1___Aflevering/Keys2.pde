class Keys2
{
  private boolean upDown = false;
  private boolean leftDown = false;
  private boolean downDown = false;
  private boolean rightDown = false;
 
 
  
  public Keys2(){}
  
  public boolean upDown()
  {
    return upDown;
  }
  
  public boolean leftDown()
  {
    return leftDown;
  }
  
  public boolean downDown()
  {
    return downDown;
  }
  
  public boolean rightDown()
  {
    return rightDown;
  }

  // A NEW ONKEYPRESSED FOR PLAYER 2
  void onKeyPressed2()
  {
    if(keyCode == UP)
    {
      upDown = true;
    }
    else if (keyCode == LEFT)
    {
      leftDown = true;
    }
    else if(keyCode == DOWN)
    {
      downDown = true;
    }
    else if(keyCode == RIGHT)
    {
      rightDown = true;
    }
  }
  //A NEW ONKEYRELEASED FOR PLAYER 2
  void onKeyReleased2()
  {
    if(keyCode == UP)
    {
      upDown = false;
    }
    else if (keyCode == LEFT)
    {
      leftDown = false;
    }
    else if(keyCode == DOWN)
    {
      downDown = false;
    }
    else if(keyCode == RIGHT)
    {
      rightDown = false;
    }
  }
}
