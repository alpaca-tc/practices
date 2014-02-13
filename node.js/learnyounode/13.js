var url = require('url'),
    http = require('http'),
    map = require('through2-map')

http.createServer(function(req, resp) {
  if (req.method != 'GET') {
    return req.end('Error Occurred')
  };

  resp.writeHead(200, { 'Content-Type' : 'application/json' })
  query = url.parse(req.url, true)

  var res = {}

  switch(query['pathname']) {
  case '/api/parsetime':
    query['query']
    var date = new Date(Date.parse(query['query']['iso']))
    res = { 'hour' : date.getHours(), 'minute' : date.getMinutes(), 'second' : date.getSeconds() }
    break;
  case '/api/unixtime':
    res = { 'unixtime' : Date.parse(query['query']['iso']) }
    break;
  }

  resp.end(JSON.stringify(res))
}).listen(Number(process.argv[2]))
