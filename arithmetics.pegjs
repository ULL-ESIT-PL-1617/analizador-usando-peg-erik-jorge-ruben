{

}
start
  = block

block
  = (CONST ID CONSTASSIGN NUMBER (COMMA ID ASSIGN NUMBER)* COLON)?
    (VAR ID (COMMA ID)* COLON)?
    (PROCEDURE ID COLON block COLON)* statement

statement
  = ID ASSIGN expression
  / CALL ID
  / Q ID
  / X expression
  / BEGIN statement (COLON statement)* END
  / IF condition THEN statement
  / WHILE condition DO statement
  / FUNCTION LEFTPAR (ID)* RIGHTPAR LEFTBRACKET block RIGHTBRACKET

condition
  = ODD expression
  / expression COMPARISON expression

expression
    = (ADDOP)? term (ADDOP term)*

term
    = factor (MULOP factor)*

factor
    = ID
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
ID = _ id:$([a-z_]i$([a-z0-9_]i*)) _ { console.log(id); return id; }
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
