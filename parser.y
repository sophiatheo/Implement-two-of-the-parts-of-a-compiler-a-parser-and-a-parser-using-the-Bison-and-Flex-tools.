%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char *s);

extern int n;
extern int yylex();
FILE *yyin;
%}

%token METAVLITI 
%token c__RETURN__
%token c__PROGRAM__ 
%token c__FUNCTION__  
%token c__END_FUNCTION__   
%token c__STRUCT__ c__TYPEDEF__ c__ENDSTRUCT__
%token c__VARS__ c__INTEGER__ c__CHAR__ 
%token c__STARTMAIN__ c__ENDMAIN__ 
%token c__PRINT__ c__BREAK__
%token c__IF__ c__THEN__ 
%token c__ELSE__ c__ELSEIF__ c__ENDIF__
%token c__SWITCH__ c__CASE__ 
%token c__ENDSWITCH__ c__DEFAULT__
%token c__WHILE__ c__ENDWHILE__
%token c__FOR__ c__TO__ c__STEP__ c__ENDFOR__
%token c__AND__ c__OR__
%token c__NUMBER__ c__CHR__
%token c__GREATER__ c__LOWER__ c__EQUAL__ c__NOTEQUAL__ 


%start start_rule

%%


start_rule: 	c__PROGRAM__ METAVLITI diloseis_arxikes vasiko ;

diloseis_arxikes:	diloseis 
					| diloseis_arxikes diloseis;


diloseis:	synartiseis 
			| domes  |;


synartiseis: 	synartisi 
				| synartiseis synartisi;
synartisi:	c__FUNCTION__ METAVLITI '(' metavlites ')' 
					diloseis_metavlitwn 
						seira_entolwn 
						c__RETURN__ ekfrasi_arithmitiki ';' 
					c__END_FUNCTION__  ;

domes:	entoli_struct 
		| domes entoli_struct;	
		
vasiko: 	c__STARTMAIN__ diloseis_metavlitwn seira_entolwn c__ENDMAIN__ ;
	
entoli_struct: 	c__STRUCT__ METAVLITI diloseis_metavlitwn c__ENDSTRUCT__ ';' |
		c__TYPEDEF__ c__STRUCT__ METAVLITI diloseis_metavlitwn c__ENDSTRUCT__ ';' ;

diloseis_metavlitwn:	| seira_vars 
						| diloseis_metavlitwn seira_vars  ;
						
						
seira_vars:	c__VARS__ typos 
				metavlites_me_kommata ';';	

typos:		c__INTEGER__ | c__CHAR__;

metavlites:	| metavlites_me_kommata;

metavlites_me_kommata:		metavl_2 
							| metavlites_me_kommata ',' metavl_2;


metavl_2:		METAVLITI 
				| METAVLITI '[' c__NUMBER__ ']'; 


seira_entolwn:	mia_entoli | 
		seira_entolwn mia_entoli;

mia_entoli: 		anathesi_timis| 
					while |	print |  
					for  | 	if_entoli  |
					switch_entoli|
					c__BREAK__ ;

anathesi_timis: 	METAVLITI '=' ekfrasi_arithmitiki ';' ;

while: 	c__WHILE__ '(' syntikes ')' seira_entolwn c__ENDWHILE__;

print: 	c__PRINT__ '(' c__CHR__  ')'';' | 	
		c__PRINT__ '(' c__CHR__ ',' ekfrasi_arithmitiki ')'';';

for: 		c__FOR__ METAVLITI  ':' '=' ekfrasi_arithmitiki c__TO__ ekfrasi_arithmitiki c__STEP__ ekfrasi_arithmitiki
		seira_entolwn 
		c__ENDFOR__;


if_entoli: 		c__IF__ '(' syntikes ')'  c__THEN__  
					seira_entolwn 
					else_elseif 
				c__ENDIF__ ;
				
				
				
else_elseif:		elseif_kommati else_kommati 
					| else_kommati |;
					
					
					
else_kommati:		c__ELSE__ seira_entolwn ;


elseif_kommati:	elseif1 | elseif_kommati elseif1;
elseif1:	c__ELSEIF__  '(' syntikes ')';

switch_entoli: 	c__SWITCH__ '(' ekfrasi_arithmitiki ')' 
					case_kommati 
					default_entoli 
					c__ENDSWITCH__ ;

case_kommati:		case 
					| case_kommati case ;
					
case: 				c__CASE__ '(' ekfrasi_arithmitiki ')' 
					seira_entolwn ; 
					
					
default_entoli:		| c__DEFAULT__ seira_entolwn;

syntikes: 		ekfrasi_arithmitiki symvola_sygkrisewn ekfrasi_arithmitiki | 
				syntikes and_or syntikes ;


symvola_sygkrisewn: 		'>' 
							| '<' | 
							c__GREATER__ 
							| c__LOWER__ 
							| c__EQUAL__ 
							|c__NOTEQUAL__;		
		
and_or: 	c__AND__ 
			| c__OR__;



ekfrasi_arithmitiki: 		praxeis | ekfrasi_arithmitiki praxi ekfrasi_arithmitiki ;

praxeis: 					ekfrasi_metv | 
							'(' ekfrasi_arithmitiki ')' ;

praxi: 						'+'|
							'-'|
							'/'|
							'*'|
							'^';

ekfrasi_metv: 	METAVLITI 
				| METAVLITI '(' ekfrasi_metv ')' 
					| METAVLITI '[' ekfrasi_arithmitiki ']' 
					| c__NUMBER__ 
					| c__CHR__ ;


%%

// i synartisi afti kalitai otan exoume thema sto parser
void yyerror(const char *s)
{
       
      printf("Lathos sti grammi=%d \n", n );
       
       exit(1);
      		
}


// vasiki synartisi pou kalei ton analyti mas
int main(int argc, char *argv[]){
n=1;
FILE *file;
	
	
	file=fopen(argv[1],"r");
	
	yyin = file; 
	yyparse();
	fclose(file);
		
	
	printf("\n\nTo programma elegxthike kai einai sosto syntaktika !\n\n");
	
	
	return 0;
	
}	
	
	



