class ShipManager{

  HashMap<Ship> ships;

  ShipManager(){
    ships = new HashMap(); 
  }

  Ship getShip( String id ){
    if( ships.get( id ) == null ){
      ships.put( id, new Ship() );
    }

    Ship s = (Ship) ships.get( id );
    return s;
  }

}

Pvector vert = new PVector( 0, -10 );

class Ship{
  PVector velocity;
  PVector position;
  color col;

  Ship( col_ ){
    col = col_;
    position = new PVector( width/2, height/2 );
    velocity = new PVector( 0, -1 );
  }

  void display(){
    //move
    beginShape();
    fill( col );
    stroke( col );
    position.add( velocity );

    if( position.x > width ) position.x = 0;
    else if( position.x < 0 ) position.x = width;
    if( position.y > height ) position.y = 0;
    else if( position.y < 0 ) position.y = height;

    //vertex( position.x, position.y - 10 );
    //vertex( position.x + 7, position.y + 7 );
    //vertex( position.x - 7, position.y + 7 );
    ellipse( position.x, position.y, 10, 10 );
    PVector front = PVector.add( position, PVector.mult( velocity, 10 ) );
    line( position.x, position.y, front.x, front.y ); 
    //console.log( position.normalize() );
    endShape();
    
    if( velocity.mag() > 1 ){
      velocity.div( 1.05 );
    }
    
  }

  void increaseSpeed(){
    if( velocity.mag() < 10 ){
      velocity.mult( 1.2 );
    }
  }

  void turn( Boolean onLeft ){
    float theta = PI/40;
    if( onLeft ) theta = -theta;
    float xTemp = velocity.x;
    velocity.x = velocity.x*cos(theta) - velocity.y*sin(theta);
    velocity.y = xTemp*sin(theta) + velocity.y*cos(theta);
  }

  
}


ShipManager manager = new ShipManager();
Ship myShip = null;

void setup(){
  size( 400, 400 );
  background(0);
  //frameRate(5);
}

void draw(){
  background(0);
  Iterator i = manager.ships.entrySet().iterator();
  while (i.hasNext() ){
    Map.Entry s = (Map.Entry) i.next();
    s.getValue().display();
  }

  if( keyPressed == true ){
    if( keyCode == UP ){
      myShip.increaseSpeed();
    }
    if( keyCode == LEFT ){
      myShip.turn( true );  
    }
    if( keyCode == RIGHT ){
      myShip.turn( false );
    }
    sendShipParam( myShip.velocity.x, myShip.velocity.y );
  }
}

void setShip( float id, float x, float y ){
  manager.get( id ).velocity.set( x, y );
}

void createShip( String id, float r, float g, float b ){
  if( myShip == null ){
    myShip = new Ship( color( r, g, b ) ) ;
    manager.ships.put( id, myShip );
  }else{
    manager.ships.put( id, new Ship( color( r, g, b ) ) );
  }
}

