Player p;
EnemyController enemyController;
ArrayList<Mobile> mobs;
int totalKills;
final float collisionBuffer = 5;

void setup() {
  fullScreen();
  //size(400, 400);
  textAlign(CENTER, CENTER);
  mobs = new ArrayList<Mobile>();
  p = new Player(width/2, height/2);
  mobs.add(p);
  enemyController = new EnemyController();
}

void draw() {
  background(255);
  display();
  Timer.update(millis());

  if (p.dead()) {
    gameOver();
    return;
  }

  enemyController.update();
  ArrayList<Mobile> deletedMobs = new ArrayList<Mobile>();
  for (Mobile mob : mobs) {
    mob.update();
    if (mob instanceof Destroyable && ((Destroyable) mob).flagged()) {
      deletedMobs.add(mob);
    }
  }

  mobs.removeAll(deletedMobs);
}

void mousePressed() {
  if (p.dead) {
    reset();
    return;
  }

  p.shoot();
}

void display() {
  strokeWeight(0.5);
  stroke(200);
  for (int i = 0; i < width; i += 25) {
    line(i, 0, i, height);
  }
  for (int j = 0; j < height; j += 25) {
    line(0, j, width, j);
  }
}

void gameOver() {
  background(0);
  textSize(32);
  fill(155, 0, 0);
  text("GAME OVER", width/2, height/4);
  fill(255);
  text("You killed " + totalKills + " enemies.", width/2, height/2);
}

void reset() {
  mobs.clear();
  totalKills = 0;
  enemyController.reset();
  p.respawn();
}
