abstract class Animal
{
  protected Cell myCell; 
  protected Cell myDestination;
  protected Cell oldCell;

  protected boolean isAlive;
  protected boolean hasActed;
  protected int hunger;
  protected int food;
  protected color myColor1;
  protected color myColor2;
  protected color myColor3;
  protected color myStroke;
  protected int deathTimer;
  Animal (Cell c)
  {
    myCell = c;
    hasActed = false;
    isAlive = true;
  }
  public void display()
  {
    stroke (myStroke);
    fill (myColor1, myColor2, myColor3);
    rect (myCell.getX() * CELL_SIZE, myCell.getY() * CELL_SIZE, CELL_SIZE, CELL_SIZE);
  }
  public void act()
  {
    if (!hasActed)
    {
      plan();
      move();
      eat();
      hunger();
      reproduce();
      hasActed = true;
    }
    int timer = 0;
    if (myCell.getTile().tileID == 3 && deathTimer == 0)
    {
      deathTimer = 40;
      die();
    }
    if (timer > 0)
    {
      timer --;
    }
  }
  abstract void eat();
  abstract void reproduce();

  public void update()
  {
    hasActed = false;
  }

  public void plan()
  {
    int xDiff = (int) random(-2, 2);
    int yDiff = (int) random(-2, 2);

    int xDest = myCell.getX() + xDiff;
    int yDest = myCell.getY() + yDiff;

    if (inBounds (xDest, yDest))
    {
      myDestination = cells [xDest][yDest];
    }
  }
  public void hunger()
  {
    food -= hunger;
    if (food < 0) die();
  }
  public void die()
  {
    isAlive = false;
    myCell.clearAnimal();
  }
  public int getFood()
  {
    return food;
  }
  public boolean isAlive()
  {
    return isAlive;
  }
  public boolean canMove()
  {
    return isAlive && myDestination != null && myDestination.getTile().canPass() && myDestination.getTile().canPass2() && !myDestination.hasAnimal();
  }

  public void move()
  {
    if (canMove())
    {
      myCell.clearAnimal();
      myDestination.addAnimal(this);
      oldCell = myCell;
      myCell = myDestination;
    }
  }
}