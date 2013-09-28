
class SnakeManager{

  HashMap<Snake> snakes;

  SnakeManager(){
    snakes = new HashMap(); 
  }

  Snake getSnake( String id ){
    if( snakes.get( id ) == null ){
      snakes.put( id, new Snake() );
    }

    Snake s = (Snake) snakes.get( id );
    return s;
  }

}

class Snake{
  float oldX = null;
  float oldY = null;
  color col;

  Snake(){
    //init new snake with random color
    col = color( random(255), random(255), random(255) );
  }

  void drawNewSegment( float newX, float newY ){
    if( oldY != null && oldX != null ){
      stroke( col );
      line( oldX, oldY, newX, newY );
    }
    oldX = newX;
    oldY = newY;
  }
}


SnakeManager manager = new SnakeManager();

void setup(){
  size( 800, 800 );
  background(0);
}

void draw(){
  //fade effect
  fill( 0, 1 );
  rect( 0, 0, width, height); 
}


void mouseMoved(){
  sendPosition( mouseX, mouseY );
}

void drawLine( String snakeId, float x, float y ){
  manager.getSnake( snakeId ).drawNewSegment( x, y );
}
