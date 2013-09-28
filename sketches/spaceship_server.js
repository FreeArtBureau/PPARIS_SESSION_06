var app = require('express')()
, server = require('http').createServer(app)
, io = require('socket.io').listen(server);

server.listen(8080);


var ships = {};

io.sockets.on('connection', function( socket ){
	var newShip = 
	io.sockets.emit( 'newship', {
		color:{
			r: Math.round( Math.random() * 255 ),
			g: Math.round( Math.random() * 255 ),
			b: Math.round( Math.random() * 255 )
		},
		id: socket.id
	});
	socket.on('setship', function( dataString ){
		var shipParams = JSON.parse( dataString );
		shipParams.id = socket.id;
		io.sockets.emit( 'setship', shipParams );
	});
});

