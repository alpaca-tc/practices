var argv = process.argv
var sum = 0;
for (var i = 2, len = argv.length; i < len; i += 1) {
  sum += Number(argv[i]);
}

console.log(sum);
