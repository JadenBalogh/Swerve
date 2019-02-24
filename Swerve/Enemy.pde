public class Enemy extends Mobile implements Destroyable { //<>//
  private boolean flagged;
  private float x, y;
  private float maxRadius = 6;
  private float maxSpeed = 8;
  private int maxHealth = 5;
  private int maxDamage = 5;
  private float radius = 2.5;
  private float speed = 4;
  private int health = 1;
  private int damage = 1;
  private float radiusGrowth = 0.5;
  private float speedGrowth = 0.5;
  private int healthGrowth = 1;
  private int damageGrowth = 1;

  public Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public Enemy() {
    x = 0;
    y = 0;
  }

  public void update() {
    PVector dir = getDirection();
    float v = getDistanceScaling() * speed;
    x += dir.x * v;
    y += dir.y * v;
    collide();
    display();
  }

  public void damage(int damage) {
    health -= damage;
    if (health <= 0)
      flag();
  }

  public boolean flagged() {
    return flagged;
  }

  public void flag() {
    if (!flagged) {
      flagged = true;
      enemyController.enemyCount--;
    }
  }

  public float getRadius() {
    return radius;
  }

  private void collide() {
    if (dist(x, y, p.x, p.y) <= (radius + p.getRadius())) {
      flag();
      p.damage(damage);
    }

    for (Mobile mob : mobs) {
      if (mob instanceof Enemy) {
        Enemy enemy = (Enemy) mob;
        if (enemy != this && !enemy.flagged() && dist(x, y, enemy.x, enemy.y) <= (radius + enemy.getRadius() + collisionBuffer)) {
          flag();
          enemy.flag();
          combine(enemy);
          return;
        }
      }
    }
  }

  private void combine(Enemy other) {
    float newX = (x + other.x) / 2;
    float newY = (y + other.y) / 2;
    Enemy newEnemy = new Enemy(newX, newY);
    newEnemy.radius = Math.min(Math.max(radius, other.radius) + radiusGrowth, maxRadius);
    newEnemy.speed = Math.min(Math.max(speed, other.speed) + speedGrowth, maxSpeed);
    newEnemy.health = Math.min(Math.max(health, other.health) + healthGrowth, maxHealth);
    newEnemy.damage = Math.min(Math.max(damage, other.damage) + damageGrowth, maxDamage);
    enemyController.spawn(newEnemy);
  }

  private void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    float angle = PI/4;
    float scale = radius*2; 
    PVector p1 = getDirection().rotate(angle).mult(-scale);
    PVector p2 = getDirection().rotate(-angle).mult(-scale);
    triangle(x, y, x + p1.x, y + p1.y, x + p2.x, y + p2.y);
  }

  private float getDistanceScaling() {
    float d = dist(x, y, p.x, p.y);
    float maxD = dist(0, 0, width, height);
    return map(log(d), 0, log(maxD), 1, 0);
  }

  private PVector getDirection() {
    return new PVector(
      p.x - x, 
      p.y - y
      ).normalize();
  }
}
