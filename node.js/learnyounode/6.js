var filterFn = require('./6-1.js'),
    dir = process.argv[2],
    extname = process.argv[3];

filterFn(dir, extname, function(err, data) {
    if (err)
      console.error(err);

    data.forEach(function(file) {
        console.log(file);
    });
});
