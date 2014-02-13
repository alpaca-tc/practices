var http = require('http'),
    bl = require('bl')

http.get(process.argv[2], function(resp) {
    resp.pipe(bl(function (err, data) {
          if(err)
            return console.error(err)
          data = data.toString()
          console.log(data.length);
          console.log(data);
    }))
})
