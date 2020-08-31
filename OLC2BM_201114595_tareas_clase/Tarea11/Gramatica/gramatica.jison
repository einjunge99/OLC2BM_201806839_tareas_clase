%{
var cont = 0
function new_temp(){
        cont++
        return "t"+cont
}
%}

%lex

entero [0-9]+
numero {entero}("."{entero})?
%%

\s+											// ignora los espacios en blanco

{numero}  return 'numero'

"("	    return '(';
")"		return ')';

"+"		return '+';
"-"		return '-';
"*"		return '*';
"/"		return '/';

<<EOF>>		return 'EOF';
. 		    { console.log("Error léxico: " + yytext ); }

/lex

%start S
%%

S
: E EOF{
  return $1.C3D
}
| EOF{
  return "Sin código de tres direcciones"
}
;

E
: E '+' T{
    temp=new_temp();  
    $$={TMP:temp,C3D:$1.C3D+$3.C3D+"\n"+temp+"="+$1.TMP+"+"+$3.TMP};
}
| E '-' T{
    temp=new_temp();  
    $$={TMP:"t"+cont,C3D:$1.C3D+$3.C3D+"\n"+temp+"="+$1.TMP+"-"+$3.TMP};
}
| T{
  $$=$1
}
;

T
: T '*' F{
    temp=new_temp();  
    $$={TMP:temp,C3D:$1.C3D+$3.C3D+"\n"+temp+"="+$1.TMP+"*"+$3.TMP};
}
| T '/' F{
    temp=new_temp();  
    $$={TMP:temp,C3D:$1.C3D+$3.C3D+"\n"+temp+"="+$1.TMP+"/"+$3.TMP};
}
| F{
  $$=$1
}
;

F
: '(' E ')'{
  $$=$2
}
| numero{
  $$={TMP:$1,C3D:""}
}			
;