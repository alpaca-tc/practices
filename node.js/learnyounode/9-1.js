var http = require('http'),
    bl = require('bl'),
    result = [],
    count = 0

function printResult(argument) {
  for (var i = 0; i < 3; i += 1) {
    console.log(result[i]);
  }
}

function httpGet(index) {
  http.get(process.argv[2 + index], function(resp) {
    resp.setEncoding('utf8')
    resp.pipe(bl(function (err, data) {
      if (err)
        return console.error(err);

      result[index] = data.toString()
      count += 1

      if (count == 3) {
        printResult()
      };
    }))
  })
}

for (var i = 0; i < 3; i += 1) {
  httpGet(i)
}
