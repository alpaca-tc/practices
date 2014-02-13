var http = require('http'),
    fs = require('fs')

http.createServer(function(req, res) {
  var stream = fs.createReadStream(process.argv[3])
  stream.on('open', function() {
    stream.pipe(res)
  })

  stream.on('error', function() {
    stream.pipe(err)
  })
}).listen(process.argv[2])
