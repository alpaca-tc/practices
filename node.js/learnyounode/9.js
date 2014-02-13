var http = require('http')

function get(args) {
  var url = args.pop()

  http.get(url, function(resp) {
    resp.setEncoding('utf8')
    var words = []
    resp.on('data', function(data) {
      words.push(data)
    })
    resp.on('error', console.error)
    resp.on('end', function() {
      console.log(words.join(''));
      get(args)
    })
  })
}

get([process.argv[4], process.argv[3], process.argv[2]])
