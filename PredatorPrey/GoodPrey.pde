class goodPrey extends Prey
{
  private float mutateChance;
  goodPrey(Cell c)
  {
    super(c);
    food = GOOD_PREY_STARTING_FOOD;
    hunger = GOOD_PREY_HUNGER_RATE;
    myColor1 = 255;
    myColor2 = 255;
    myColor3 = 0;
    myStroke = 150;
    mutateChance = .1;
  }
  boolean canMutate()
  {
    return Math.random() < mutateChance;
  }
  public void plan()
  {
    float mostFood = myCell.getTile().getGrass();
    Cell bestCell = myCell;
    Cell trackingCell;
    for (int i = -1; i < 2; i++)
    {
      for (int j = -1; j < 2; j++)
      {
        if (inBounds(myCell.getX() + i, myCell.getY() + j))
        {
          trackingCell = cells[myCell.getX() + i][myCell.getY() + j];
        } else
        {
          trackingCell = myCell;
        }
        if (mostFood <= trackingCell.getTile().getGrass() && !(trackingCell.getAnimal() instanceof Predator))
        {
          bestCell = trackingCell;
          mostFood = bestCell.getTile().getGrass();
        }
        //if (trackingCell == myCell)
        //{
        //  super.plan();
        //}
      }
    }
      super.plan();
      myDestination = bestCell;
   
  }
  public void reproduce()
  {
    if (oldCell != null && !oldCell.hasAnimal() && food > GOOD_PREY_THRESHOLD)
    {
      food /= 2;
      if (canMutate())
      {
        oldCell.addAnimal(new Prey(oldCell));
      } else
      {
        oldCell.addAnimal(new goodPrey(oldCell));
      }
    }
  }
}