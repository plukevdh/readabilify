$(function() {
  var events = $({});

  var socket = new io.Socket('localhost', {port: 7654, reconnect: true});
  socket.connect();
  socket.on('connect', function(){
    console.log('connected');
  });

  socket.on('message', function(data){
    console.log('message received', data);
    events.trigger(msg.command, msg.args);
  });

  events.bind('DL', function() {
    if(args.user != whoami.user) { return false; }
    $('#generating').hide();
    $('#mass-convert').slideDown();
  });

});

