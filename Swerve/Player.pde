public class Player extends Mobile {
  private float x, y;
  private float speed = 10;
  private float radius = 10;
  private int maxHealth = 20;
  private int health;
  private boolean dead = false;
  
  private float projectileRadius = 5;

  public Player(float x, float y) {
    this.x = x;
    this.y = y;
    health = maxHealth;
  }

  public void update() {
    PVector dir = getDirection();
    float v = speed * getDistanceScaling();
    //textSize(32);
    //fill(0);
    //text(v, width/2, height - 20);
    x += dir.x * v;
    y += dir.y * v;
    display();
  }

  public void damage(int damage) {
    health -= damage;
    if (health <= 0)
      die();
  }

  public Projectile shoot() {
    PVector dir = getDirection();
    float xOffset = dir.x * (radius + projectileRadius);
    float yOffset = dir.y * (radius + projectileRadius);
    Projectile proj = new Projectile(x + xOffset, y + yOffset, dir);
    proj.radius = projectileRadius;
    mobs.add(proj);
    return proj;
  }

  public float getRadius() {
    return radius;
  }

  public boolean dead() {
    return dead;
  }

  public void respawn() {
    mobs.add(this);
    health = maxHealth;
    x = width/2;
    y = height/2;
    dead = false;
  }
  
  private void display() {
    strokeWeight(1);
    stroke(0);
    noFill();
    ellipse(x, y, radius*2, radius*2);
    textSize(12);
    fill(0);
    text(health, x, y + (2*radius));
  }

  private void die() {
    dead = true;
  }

  private float getDistanceScaling() {
    float d = dist(x, y, mouseX, mouseY);
    float maxD = dist(0, 0, width, height);
    return norm(log(d), 0, log(maxD));
  }

  private PVector getDirection() {
    return new PVector(
      mouseX - x, 
      mouseY - y
      ).normalize();
  }
}
