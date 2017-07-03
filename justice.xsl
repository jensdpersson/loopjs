<?xml version="1.0" encoding="UTF-8"?>
<t:transform xmlns:t="http://www.w3.org/1999/XSL/Transform"
             xmlns:j="http://justice.hoverview.org/ns" version="1.0">
    <t:output method="html"/>
    <t:template match="j:campaign">
        <html>
            <head>
                <title>Hoverview Justice Test Results</title>
                <t:for-each select="j:import">
                   <script type="text/javascript" src="{@src}">//ignore me</script>
                </t:for-each>
                <script type="text/javascript">

                  <t:value-of select="j:setup"/>

                  var tests = [];
                  <t:for-each select="j:test">
                     tests.push({
                     id: '<t:value-of select="generate-id()"/>',
                     facit: '<t:value-of select="j:facit"/>',
                     run: function(<t:if test="j:action/@callback">
                                    <t:value-of select="j:action/@callback"/>
                                   </t:if>){
                        <t:value-of select="j:action"/>
                     },
                     async: '<t:value-of select="j:action/@callback"/>',
                     asyncrun: function(){
                                    var t = this;
                                    this.run(function(outcome){
                                        verdict(t, outcome);
                                    });
                                }
                    });
                  </t:for-each>
                  function verdict(test, actual){
                        var tr_elm = document.getElementById(test.id);
                        var expected = test.facit;
                        var verdict_elm = document.getElementById(test.id+'-verdict');
                        var actual_elm = document.getElementById(test.id+'-actual');
                        actual_elm.appendChild(document.createTextNode(actual));
                        if(actual == expected){
                           tr_elm.style.background = '#66CC66';
                           verdict_elm.appendChild(document.createTextNode('PASS'));
                        } else {
                           tr_elm.style.background = '#CC6666';
                           verdict_elm.appendChild(document.createTextNode('FAIL'));
                        }
                  }
                  function run_tests(){
                     for(var index = 0; index &lt; tests.length; index++){
                        var test = tests[index];

                        if(test.async != ''){
                            test.asyncrun();
                        } else {
                          try {
                            var actual = String(test.run());
                          } catch(err){
                            var actual = err;
                          }
                          verdict(test, actual);
                        }
                     }
                  }
                </script>
            </head>
            <body onload="run_tests()">
                <div>
                    This page displays the results from running the tests in the current
                    browser. Failed tests are <span style="background:#CC6666">red</span>
                    , successful tests are <span style="background:#66CC66">green</span>
                    and any <span style="background:grey">grey</span> rows mean that there
                    was an error in the test rig and the tests have not completed.
                </div>
               <table border="1">
                  <tr><th>Test</th><th>Expected</th><th>Actual</th><th>Verdict</th></tr>
               <t:for-each select="j:test">
                  <tr id="{generate-id()}" style="background:grey">
                     <td><t:value-of select="j:synopsis"/></td>
                     <td><t:value-of select="j:facit"/></td>
                     <td id="{generate-id()}-actual"></td>
                     <td id="{generate-id()}-verdict"></td>
                  </tr>
               </t:for-each>
               </table>
            </body>
        </html>
    </t:template>
</t:transform>
