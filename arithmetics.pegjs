{
  var util = require('util');
  var tree = {
  };
}
start
  = b:block {return b;}

block
  = constant:(CONST ID CONSTASSIGN NUMBER (COMMA ID CONSTASSIGN NUMBER)* COLON)?
    vars:(VAR ID (COMMA ID)* COLON)?
    proc:(PROCEDURE ID COLON block COLON)*
    est:statement
        { var bloque = {};
          var constantes = {};
          if (constant){
            constantes [constant[1]] = constant [3];
            if (constant[4]){
              constant[4].forEach( function (element){
                constantes [element[1]] = element [3];
              });
            }
          }

          var variables = {}
          if (vars){
            variables [vars[1]] = null;
            if (vars[2]){
              vars[2].forEach( function (element){
                variables [element [1]] = null;
              } );
            }
          }
          var procedimientos = {};
          proc.forEach ( function (element){
            procedimientos [element[1]] = element[3];
          });
          bloque ["constantes"] = constantes;
          bloque ["variables"] = variables;
          bloque ["procedimientos"] = procedimientos;
          bloque ["sentencias"] = est;
          return bloque;
        }

statement
  = ID ASSIGN expression
  / CALL ID
  / Q ID
  / X expression
  / BEGIN statement (COLON statement)* END
  / IF condition THEN statement
  / WHILE condition DO statement
  / FUNCTION ID LEFTPAR (ID (COMMA ID)*)? RIGHTPAR LEFTBRACKET block RIGHTBRACKET
  / expression

condition
  = ODD expression
  / expression COMPARISON expression

expression
    = (ADDOP)? term (ADDOP term)*

term
    = factor (MULOP factor)*

factor
    = ID LEFTPAR (ID (COMMA ID)*)? RIGHTPAR
    / ID
    / NUMBER
    / LEFTPAR expression RIGHTPAR

_ = $[ \t\n\r]*
ADDOP = PLUS / MINUS
MULOP = MULT / DIV
PLUS = _"+"_ {return '+';}
MINUS = _"-"_ {return '-';}
MULT = _"*"_ {return "*";}
DIV = _"/"_ {return "/";}
LEFTPAR = _"("_
RIGHTPAR = _")"_
NUMBER = _ digits:$[0-9]+ _ { return parseInt(digits, 10); }
ID = _ id:$([a-z_]i$([a-z0-9_]i*)) _ {return id; }
CONSTASSIGN = _'=' _
ASSIGN = _ ':=' _
COMMA = _","_

FUNCTION = _"function"_
LEFTBRACKET = _"{"_
RIGHTBRACKET = _"}"_
CONST = _"const"_
VAR = _"var"_
PROCEDURE = _"procedure"_
CALL = _"call"_
BEGIN = _"begin"_
END = _"end"_
IF = _"if"_
THEN = _"then"_
WHILE = _"while"_
DO = _"do"_
COMPARISON = _op:("<="/">="/"<"/">"/"==")_
COLON = _";"_
Q = _"?"_
X = _"!"_
ODD = _"odd"_
