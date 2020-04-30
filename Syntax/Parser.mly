%token FINALLY
%token GLOBALLY
%token UNTIL
%token SINCE
%token BACKTO
%token RELEASE
%token NEXT
%token LBRACK
%token RBRACK
%token LCURV
%token RCURV
%token LBRACE
%token RBRACE
%token COMMA
%token TRUE
%token FALSE
%token AND
%token OR
%token NOT
%token IFF
%token IMPLIES

%token <int> NUMBER
%token <string> PROPOSITION
%token EOF

%right IMPLIES
%right IFF
%right OR
%right AND
%right FINALLY
%right GLOBALLY
%right UNTIL
%right RELEASE
%right NEXT
%nonassoc NOT

%start main

%type <Input.t> main

%%

endpoint:
  | NUMBER { $1 }
;;

nullary:
  | TRUE {Input.True}
  | FALSE {Input.False}
  | PROPOSITION {Input.Prop (Atom.make $1)}
;;

unary:
  | NOT {Input.Not}
  | NEXT potential_interval {Input.Next $2}
  | FINALLY potential_interval {Input.Finally $2}
  | GLOBALLY potential_interval {Input.Globally $2}
;;

binary:
  | AND {Input.And}
  | OR {Input.Or}
  | IFF  {Input.Iff}
  | IMPLIES {Input.Implies}
  | UNTIL potential_interval {Input.Until $2 }
  | SINCE potential_interval {Input.Since $2 }
  | BACKTO potential_interval {Input.BackTo $2 }
  | RELEASE potential_interval {Input.Release $2}
;;

formula:
  | LCURV formula RCURV {$2}
  | formula binary  formula
    {Input.Binary ($2, $1, $3)}
  | unary formula
    {Input.Unary ($1, $2)}
  | nullary
    {Input.Nullary $1}
;;

/* whether its a symbol of closed interval*/
lbrac:
  | LBRACK {true}
  | LBRACE {false}
;;

/* whether its a symbol of closed interval*/
rbrac:
  | RBRACK {true}
  | RBRACE {false}
;;

potential_interval:
  | interval {$1}
  | {Interval.create 0 true max_int false}
;;

interval:
  | lbrac endpoint COMMA endpoint rbrac
    {
      let l=$2 and lc = $1 and r=$4 and rc=$5 in
      Interval.create l lc r rc
    }
;;

main:
  | formula EOF {$1}
;;
