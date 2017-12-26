
// loop.js
// author jensdpersson@gmail.com
function loop(){

  var obj = null;
  var defaultResult = null;
  var callback = null;

  if(arguments.length == 3){
    callback = arguments[2];
    defaultResult = arguments[1];
    obj = arguments[0];
  } else if(arguments.length == 2){
    callback = arguments[1];
    defaultResult = arguments[0];
    obj = this;
  } else if(arguments.length == 1){
    callback = arguments[0];
    defaultResult = null;
    obj = this;
  }

  if(!obj.length && obj.length != 0){
    throw 'Cannot loop over ' + obj;
  }

  var leng = obj.length;
  var index = 0;
  var lo = {
    result: defaultResult,
    stop: function(){
      index = leng;
    },
    index: function(){
      return index;
    },
    isLast: function(){
      return index >= leng;
    }
  };

  while(index < leng){
    lo.item = obj[index++];
    callback(lo);
  }

  return lo.result;
};

if(exports){
  exports.loop = loop;
}
