var app = require('express')()
, server = require('http').createServer(app)
, io = require('socket.io').listen(server);

server.listen(8080);

io.sockets.on('connection', function( socket ){
	socket.on('message', function( dataString ){
		var position = JSON.parse( dataString );
		position.id = socket.id;
		io.sockets.emit( 'message', position );
	});
});

