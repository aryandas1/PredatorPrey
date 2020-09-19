class Cell
{
  private int x;
  private int y;

  private Tile myTile;
  private Animal myAnimal;

  Cell (int x, int y)
  {
    this.x = x;
    this.y = y;
    myTile = new Tile(this);
  }
  public void setFertility()
  {
    myTile.setFertility();
  }
  public void setSlowFertility()
  {
    myTile.setSlowFertility();
  }
  public Tile getTile()
  {
    return myTile;
  }
  public boolean hasPrey()
  {
    return hasAnimal() && myAnimal instanceof Prey;
  }
  public Animal getAnimal()
  {
    return myAnimal;
  }
  public int getX()
  {
    return x;
  }
  public int getY()
  {
    return y;
  }
  public void update()
  {
    if (hasAnimal())
    {
      countAnimals();
      myAnimal.update();
    }
    countGrass += myTile.getGrass();
  }
  public void countAnimals()
  {
    if (myAnimal instanceof Prey)
    {
      countPrey++;
    }
    if (myAnimal instanceof Predator)
    {
      countPred++;
    }
    if (myAnimal instanceof goodPrey)
    {
      countGoodPrey++;
    }
    if (myAnimal instanceof goodPredator)
    {
      countGoodPred++;
    }
  }
  public void display()
  {
    myTile.display();
    if (hasAnimal())
    {
      myAnimal.display();
    }
  }
  public boolean hasAnimal()
  {
    return myAnimal != null;
  }
  public void addAnimal(Animal a)
  {
    if (hasAnimal())
    {
    } else
    {
      myAnimal = a;
    }
  }
  public void clearAnimal()
  {
    myAnimal = null;
  }
  public void act()
  {
    myTile.act();
    if (hasAnimal())
    {
      myAnimal.act();
    }
  }
}