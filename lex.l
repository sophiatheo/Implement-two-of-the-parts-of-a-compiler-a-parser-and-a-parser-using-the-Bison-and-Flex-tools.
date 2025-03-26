%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define SYM yytext[0]
#include "parser.tab.h"

// metraei tis grammes
int n;

void fun_for_comments();

%}

%option noyywrap


%%

[ \t]		{ }
[\n]		{n++; }

"PROGRAM" 	 { return c__PROGRAM__;	 }
"STARTMAIN" 	{ return c__STARTMAIN__; }
"ENDMAIN" 	{ return c__ENDMAIN__; }

"FUNCTION" 	 { return c__FUNCTION__;  }
"END_FUNCTION"   { return c__END_FUNCTION__; }
"RETURN"	 	{ return c__RETURN__; }

"VARS"		{ return c__VARS__; }
"CHAR"		{ return c__CHAR__; }
"INTEGER"	{ return c__INTEGER__; }



"STRUCT"		{	return c__STARTMAIN__;}
"ENDSTRUCT"	{	return c__ENDSTRUCT__;}
"TYPEDEF"	{	return c__TYPEDEF__;}


"WHILE"	{ return c__WHILE__; 	}
"ENDWHILE"	{ return c__ENDWHILE__; 	}



"FOR"		{ return c__FOR__; 	}
"TO"		{ return c__TO__; 	}
"STEP"		{ return c__STEP__; 	}
"ENDFOR"	{ return c__ENDFOR__; 	}



"IF"		{return c__IF__;		}
"THEN"		{ return c__THEN__; 	}
"ELSE"		{return c__ELSE__; 	}
"ELSEIF"	{return c__ELSEIF__; 	}
"ENDIF"	{return c__ENDIF__;	}



"SWITCH"	{return c__SWITCH__; 	}
"CASE"		{return c__CASE__; 	}	
"DEFAULT"	{return c__DEFAULT__; 	}
"ENDSWITCH"	{return c__ENDSWITCH__; 	}


"PRINT"	{return c__PRINT__;	}
"BREAK"	{return c__BREAK__;	}


"AND"		{ return c__AND__; 	}
"OR"		{ return c__OR__; 	}




"<="		{return c__GREATER__;		}
">="		{return c__LOWER__;		}
"=="		{return c__EQUAL__;		}		
"!="		{return c__NOTEQUAL__;		}
"/*"           {	fun_for_comments();	 }
\"([^n])*\"     { return c__CHR__;}   
">"		{ return SYM;}
"<"		{ return SYM;}
"="		{ return SYM;}
","		{ return SYM;}
"!"		{ return SYM;}
";"		{ return SYM;}
":"		{ return SYM;}
"+"		{ return SYM;}
"-"		{ return SYM;}
"*"		{ return SYM;}
"/"		{ return SYM;}
"^"		{ return SYM;}
\'	{ return SYM;}
"("	{ return SYM;}
")"	{ return SYM;}
"["	{ return SYM;}
"]"	{ return SYM;}


[0-9]+    { return c__NUMBER__ ;}

[a-zA-Z_]|([a-zA-Z_]|[0-9])*	{return METAVLITI; }


 
                          




%%

void fun_for_comments()
{

   char c;
   
   for (;;)
    {   
   	while((c=input())!='*' && c!=EOF)  if (c=='\n') n++;
	 
    if ((c=input())=='/') break;
         
     

    }  

}


