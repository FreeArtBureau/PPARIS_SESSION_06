
var https = require('https')
	, http = require('http')
	, express = require('express')
	, socketio = require('socket.io');



var username = process.argv[2]
	, password = process.argv[3]
	, host = 'stream.twitter.com'
	, auth = 'Basic ' + new Buffer(username + ':' + password).toString('base64')
	, port =  8080
	, timeout = 5000;

var coor = {
	limit:[-180,-90,180,90],
};

var options = {
	host: host,
	port: 443,
	path:'/1/statuses/filter.json?locations='+coor.limit.join(),
	method:'GET',
	headers: {
		Authorization: auth,
		Host: 'tweetping.net'
	}
};

var log = function( mess ){
	console.log( new Date().toString(), mess);
}

app = express();
var server = http.createServer( app );
var io = socketio.listen( server );

server.listen( port );

function stream(){
	log( 'stream : init ' + options.path);
	var req = https.request(options, function(res) {
		res.setEncoding('utf8');
		log( 'stream : start');
		res.on('data', function(d){
			//console.log(d);
			var tweet;
			try{
				tweet = JSON.parse(d);
			}catch(e){
				//console.log('JSON PARSE ERROR : ' + d);
				//console.log(e);
			}
			if(tweet && tweet.geo){
				//console.log( tweet );
				io.sockets.emit('tweet', unescape( encodeURIComponent( JSON.stringify(
					tweet	
				))));
			}
		});
		res.on('end', function(){
			log('stream : response end');
			setTimeout( function(){
				stream();
			}, timeout*5 );
		});
	});
	req.on('socket', function( soc ){
		soc.setTimeout( timeout );
		soc.on( 'timeout', function(){
			log('stream : timeout -- will abort');
			req.abort();
			//stream();
		});
	});
	req.on('end', function(){
		log('stream : end');
		//stream();
	});
	req.on('error', function(){
		log('stream : error');	
		setTimeout( function(){
			stream();
		}, 10*retry );
	});
	req.end();

}

stream();
