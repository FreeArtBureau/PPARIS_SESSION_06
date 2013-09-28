
void setup(){
  size( 400, 400 );
  background(50);
  noLoop();
}

void draw(){
   fill( 50, 1 );
   rect( 0, 0, width, height); 
}

void drawText( String message ){
  fill( 255, random(30, 80) );
  textSize( random( 10, 40 ) );
  text( message, random( width ), random( height ) );
}
