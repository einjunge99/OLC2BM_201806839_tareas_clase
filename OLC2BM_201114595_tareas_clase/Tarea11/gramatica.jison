
%{
var cont=0
%}

%lex

entero [0-9]+
numero {entero}("."{entero})?
%%

\s+											// ignora los espacios en blanco

{numero}  return 'numero'

"("	      return '(';
")"			  return ')';

"+"				return '+';
"-"				return '-';
"**"			return '**';
"*"		  	return '*';
"/"			 	return '/';

<<EOF>>		return 'EOF';
. 				return 'Error léxico'

/lex

%start S
%%

S
: E EOF{
  return " "+$1.C3D
}
| EOF{
  return "Sin código de tres direcciones"
}
;

E
: E '+' T{
  $$={TMP:"t"+cont,C3D:$1.C3D+$3.C3D+"t"+cont+"="+$1.TMP+"+"+$3.TMP+" "};
  cont++
}
| E '-' T{
  $$={TMP:"t"+cont,C3D:$1.C3D+$3.C3D+"t"+cont+"="+$1.TMP+"-"+$3.TMP+" "};
  cont++
}
| T{
  $$=$1
}
;

T
: T '*' F{
  $$={TMP:"t"+cont,C3D:$1.C3D+$3.C3D+"t"+cont+"="+$1.TMP+"*"+$3.TMP+" "};
  cont++
}
| T '/' F{
  $$={TMP:"t"+cont,C3D:$1.C3D+$3.C3D+"t"+cont+"="+$1.TMP+"/"+$3.TMP+" "};
  cont++
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
