class Datapoint
{
  private int grass;
  private int prey;
  private int predator;
  private float time;
  //5567247, 1593, 1882, 712
  Datapoint(int grass, int prey, int predator, float time)
  {
    this.grass = grass;
    this.prey = prey;
    this.predator = predator;
    this.time = time;
  }
  public int getGrass()
  {
    return grass;
  }
  public int getPrey()
  {
    return prey;
  }
  public int getPredator()
  {
    return predator;
  }
  public float getTime()
  {
    return time;
  }
}