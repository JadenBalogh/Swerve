public class EnemyController {
  public ArrayList<Enemy> spawnList;
  
  private int maxEnemies = 25;
  private int enemyCount = 0;
  
  private float spawnRate = 3;
  private float spawnTimer = 0;

  public EnemyController() {
    spawnList = new ArrayList<Enemy>();
  }

  public void update() {
    spawnTimer += Timer.deltaTime;
    
    if (spawnTimer >= 1/spawnRate && enemyCount < maxEnemies) {
      spawnTimer = 0;
      Enemy enemy = new Enemy();
      randomizeSpawnPosition(enemy);
      spawn(enemy);
    }
    
    for (Enemy enemy : spawnList) {
      mobs.add(enemy);
    }
    
    spawnList.clear();
  }
  
  public void spawn(Enemy enemy) {
    spawnList.add(enemy); 
    enemyCount++;
  }

  public void reset() {
    enemyCount = 0;
    spawnTimer = 0;
  }
  
  private void randomizeSpawnPosition(Enemy enemy) {
    int quad = (int) random(0, 4); // 0=t, 1=r, 2=b, 3=l
    switch (quad) {
    case 0:
      enemy.x = random(-10, width + 10);
      enemy.y = height + 10;
      break;
    case 1:
      enemy.x = width + 10;
      enemy.y = random(-10, height + 10);
      break;
    case 2:
      enemy.x = random(-10, width + 10);
      enemy.y = -10;
      break;
    case 3:
      enemy.x = -10;
      enemy.y = random(-10, height + 10);
      break;
    }
  }
}
