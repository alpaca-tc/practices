var url = process.argv[2],
    http = require('http')

http.get(url, function(resp) {
    resp.setEncoding('utf8')

    var words = []
    resp.on('data', function(word) {
        words.push(word);
    })
    resp.on('error', console.error)

    resp.on('end', function(){
        console.log(words.join('').length);
        console.log(words.join(''));
    })
})
