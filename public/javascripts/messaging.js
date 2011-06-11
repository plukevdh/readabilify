$(function() {
  var events = $({});

  var socket = new io.Socket('readabilify.webbyapp.com', {port: 3001, reconnect: true, rememberTransport: false});
  socket.connect();
  socket.on('connect', function(){
    console.log('connected');
  });

  socket.on('message', function(data){
    console.log('message received', data);
    events.trigger(data.command, JSON.parse(data.args));
  });

  events.bind('notify:download', function(e, args) {
    if(args.user != whoami.user) { return false; }
    $('#generating').hide();
    $('#mass-convert').slideDown();
  });

});

