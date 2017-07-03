# loopjs
Loop.js is a very small, but powerful, utility for looping over array-like objects. 
It enables the classical functional patterns like map, filter, fold and find with a single simple operation and 
features the ability to break out of the loop early. 

<pre>
var result = loop(arrayLike, defaultResult, function(lo){ 
    var theCurrentItem = lo.item; 
    var theCurrentIndex = lo.index(); 
    var theResultSoFar = lo.result; //Starts with the value of the defaultResult parameter, and returned at end of iteration 
    var isLastItemInTheArray = lo.isLast(); 
    lo.stop(); //break out of loop 
});
</pre>
