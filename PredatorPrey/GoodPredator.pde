class goodPredator extends Predator
{
  private float mutateChance;
  goodPredator(Cell c)
  {
    super(c);
    food = GOOD_PREDATOR_STARTING_FOOD;
    hunger = GOOD_PREDATOR_HUNGER_RATE;
    myColor1 = 255;
    myColor2 = 0;
    myColor3 = 0;
    myStroke = 50;
    mutateChance = .1;
  }
  boolean canMutate()
  {
    return Math.random() < mutateChance;
  }
  public void plan()
  {
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
        if ((trackingCell.hasPrey()))
        {
          myDestination = trackingCell;
        }
        if (trackingCell == myCell)
        {
          super.plan();
        }
      }
    }
    //myDestination = bestCell;
    //super.plan();
  }
  public void reproduce()
  {
    if (oldCell != null && !oldCell.hasAnimal() && food > GOOD_PREDATOR_THRESHOLD)
    {
      food /= 2;
      if (canMutate())
      {
        oldCell.addAnimal(new Predator(oldCell));
      } else
      {
        oldCell.addAnimal(new goodPredator(oldCell));
      }
    }
  }
}