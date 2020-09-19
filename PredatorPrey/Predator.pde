class Predator extends Animal
{
  private float mutateChance;
  Predator (Cell c)
  {
    super(c);
    food = PREDATOR_STARTING_FOOD;
    hunger = PREDATOR_HUNGER_RATE;
    myColor1 = 30;
    myColor2 = 30;
    myColor3 = 30;
    myStroke = 50;
    mutateChance = .1;
  }
  boolean canMutate()
  {
    return Math.random() < mutateChance;
  }
  public void eat()
  {
    if (myDestination != null && myDestination.hasPrey())
    {
      food += myDestination.getAnimal().getFood();
      myDestination.clearAnimal();
    }
  }
  public void reproduce()
  {
    if (oldCell != null && !oldCell.hasAnimal() && food > PREDATOR_THRESHOLD)
    {
      food /= 2;
      if (canMutate())
      {
        oldCell.addAnimal(new goodPredator(oldCell));
      } else
      {
        oldCell.addAnimal(new Predator(oldCell));
      }
    }
  }
}