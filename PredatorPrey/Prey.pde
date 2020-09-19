class Prey extends Animal
{
  private float mutateChance;
  Prey (Cell c)
  {
    super(c);
    food = PREY_STARTING_FOOD;
    hunger = PREY_HUNGER_RATE;
    myColor1 = 255;
    myColor2 = 255;
    myColor3 = 255;
    myStroke = 150;
    mutateChance = .1;
  }
  boolean canMutate()
  {
    return Math.random() < mutateChance;
  }
  public void eat()
  {
    float grass = myCell.getTile().getGrass();
    myCell.getTile().removeGrass(grass);
    food += grass;
    if (myCell.getTile().getGrass() > MAX_EAT) 
    {
      grass = MAX_EAT;
    }
  }
  public void reproduce()
  {
    if (oldCell != null && !oldCell.hasAnimal() && food > PREY_THRESHOLD)
    {
      food /= 2;
      if (canMutate())
      {
        oldCell.addAnimal(new goodPrey(oldCell));
      } else
      {
        oldCell.addAnimal(new Prey(oldCell));
      }
    }
  }
}