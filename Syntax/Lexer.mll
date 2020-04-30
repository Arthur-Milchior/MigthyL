{
  open Parser;;
  let line = ref 1;;
  (*The list of term which should not appear in propositions *)
  let re = Str.regexp_string "prop|F|G|U|R|X";;
}

let num = ['0'-'9']+
let prop = ['A'-'Z' 'a'-'z']+ (['A'-'Z' 'a'-'z'] | ['0'-'9'] | '_')*

rule token = parse
    | "(*"          { comments 0 lexbuf }
    | [' ' '\t']    { token lexbuf }
    | '\n'          { incr line; token lexbuf }
    | 'F'           { FINALLY }
    | 'G'           { GLOBALLY }
    | 'U'           { UNTIL }
    | 'R'           { RELEASE }
    | 'S'           { SINCE }
    | 'B'           { BACK }
    | 'X'           { NEXT }
    | '['           { LBRACK }
    | ']'           { RBRACK }
    | '{'           { LCURV }
    | '}'           { RCURV }
    | '('           { LBRACE }
    | ')'           { RBRACE }
    | ','           { COMMA }
    | "true"        { TRUE }
    | "True"        { TRUE }
    | "TRUE"        { TRUE }
    | "false"       { FALSE }
    | "False"       { FALSE }
    | "FALSE"       { FALSE }
    | "and"         { AND }
    | "And"         { AND }
    | "AND"         { AND }
    | "&&"          { AND }
    | "&"           { AND }
    | "or"          { OR }
    | "Or"          { OR }
    | "OR"          { OR }
    | "||"          { OR }
    | "|"           { OR }
    | '!'           { NOT }
    | "<->"         { IFF }
    | "->"          { IMPLIES }


    | num as n      { NUMBER(int_of_string n) }
    | "infty"       { NUMBER(max_int) } (* this line should be put before varname *)
    | prop as p     {try ignore (Str.search_forward re p 0);
                         failwith ("Please, avoid using prop, F, G, U, R and X in proposition Name")
                     with Not_found -> PROPOSITION(p) }
    | eof           { EOF }
    | _             { failwith ("Error at line " ^ string_of_int !line) }

and comments level = parse
    | "*)"          { if level = 0 then token lexbuf else comments (level - 1) lexbuf }
    | "(*"          { comments (level + 1) lexbuf }
    | eof           { failwith "comments are not closed" }
    | _             { comments level lexbuf }

