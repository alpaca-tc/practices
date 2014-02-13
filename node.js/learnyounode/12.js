var http = require('http'),
    map = require('through2-map')

http.createServer(function(req, resp) {
  if (req.method !== 'POST')
    return resp.end('error occurred')

  req.pipe(map(function(chunk) {
    return chunk.toString().toUpperCase()
  })).pipe(resp)
}).listen(Number(process.argv[2]))
