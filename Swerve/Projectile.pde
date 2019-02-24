public class Projectile extends Mobile implements Destroyable { //<>//
  private float x, y;
  private float radius = 5;
  private float speed = 10;
  private PVector direction;
  private boolean flagged = false;

  public Projectile(float x, float y, PVector direction) {
    this.x = x;
    this.y = y;
    this.direction = direction;
  }

  public void update() {
    x += direction.x * speed;
    y += direction.y * speed;
    destroyOffscreen();
    collide();
    rect(x, y, radius*2, radius*2);
  }

  public boolean flagged() {
    return flagged;
  }

  public void flag() {
    flagged = true;
  }

  public float getRadius() {
    return radius;
  }

  private void collide() {
    for (Mobile mob : mobs) {
      if (mob instanceof Enemy) {
        Enemy enemy = (Enemy) mob;
        if (dist(x, y, enemy.x, enemy.y) <= (radius + enemy.getRadius() + collisionBuffer)) {
          flag();
          enemy.flag();
          totalKills++;
        }
      }
    }
  }

  private void destroyOffscreen() {
    if (x < 0 - radius || x > width + radius || y < 0 - radius || y > height + radius) {
      flag();
    }
  }
}
