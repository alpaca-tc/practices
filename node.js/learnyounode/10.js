var net = require('net')

function fill_number(value) {
  return (String(value).length == 1) ? '0' + value : value
}

var server = net.createServer(function(socket) {
  var now = new Date()

  var month = fill_number(now.getMonth() + 1)
  var date = now.getFullYear() + '-' + month + '-' + now.getDate()
  var time = now.getHours() + ':' + fill_number(now.getMinutes())
  var display = date + ' ' + time
  socket.write(display).end()
})
server.listen(Number(process.argv[2]))

