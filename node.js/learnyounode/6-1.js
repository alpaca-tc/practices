var fs = require('fs'),
    path = require('path');

module.exports = function (dir, extname, callback) {
  fs.readdir(dir, function(err, list) {
      if(err)
        return callback(err, null);

      list_filtered = list.filter(function (file) {
          return path.extname(file) === '.' + extname
      });

      callback(null, list_filtered);
  });
}
