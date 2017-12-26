var loop = require('./loop.js').loop;

var result = loop(['Hello', ' World', "!"], "", function(lo){
  lo.result += lo.item;
});

console.log(result);
