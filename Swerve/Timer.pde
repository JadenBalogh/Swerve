public static class Timer
{
  private static float lastTime;
  public static float deltaTime;

  // Operates in milliseconds
  public static void update(float currentTime)
  {
    currentTime = currentTime/1000;
    deltaTime = currentTime - lastTime;
    lastTime = currentTime;
  }
}
