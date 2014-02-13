var fs = require('fs')
var dir = process.argv[2]
fs.readdir(dir, function(err, list) {
    var filter = new RegExp('\\.' + process.argv[3] + '$')

    for (var i = 0, len = list.length; i < len; i += 1) {
      var file = list[i];
      if (filter.test(file)) {
        console.log(file);
      };
    }
});
