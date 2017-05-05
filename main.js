var PEG = require("./arithmetics.js");
var util = require('util')
var input = process.argv[2] || "5+3*2";
console.log(`Processing <${input}>`);
var r = PEG.parse(input);
util.inspect
//console.log(r);
console.log(util.inspect(r, false, null))
