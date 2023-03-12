%{
    open Past
    (* open Grammar *)
    %}
(* tokens *)
%token EOF LPAR RPAR SQLPAR SQRPAR
(* keywords *)
%token SEMICOLON COMMA
%token HGATE XGATE CXGATE
%token <string> STRING
%token <int> NUMBER

(* start symbol *)
%start <Past.prog> prog_eof
%on_error_reduce statements
%%

prog_eof:
  | SQLPAR init=init SQRPAR  s=statements ; EOF { (init, s) }
;
init :
  | s1=NUMBER COMMA s2=init {s1 :: s2}
  | s1=NUMBER {[s1]}
;
statements:
  | s1=statement SEMICOLON s2=statements {s1 :: s2}
  | s1=statement {[s1]}
;
statement:
  | HGATE idx=NUMBER {{loc = $startpos; x = H idx}}
  | XGATE idx=NUMBER {{loc = $startpos; x = X idx}}
  | CXGATE LPAR idx1=NUMBER COMMA idx2=NUMBER RPAR {{loc = $startpos; x = CX (idx1, idx2)}}
;
%%
