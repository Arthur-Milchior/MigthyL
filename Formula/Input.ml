open Format;;

(** The type of formula as in the input *)
type nullary =
  | True
  | False
  | Prop of Atom.t;;
let format_nullary fmt = function
  | True  -> fprintf fmt "true"
  | False -> fprintf fmt "false"
  | Prop atom -> Atom.format fmt atom;;

type unary =
  | Not
  | Brace
  | Next of Interval.t
  | Finally of Interval.t
  | Globally of Interval.t
  | SomeTimeInThePast of Interval.t
  | GloballyInThePast of Interval.t
;;
let format_unary fmt = function
  | Not -> fprintf fmt "!"
  | Brace -> failwith ("brace can't be printed in unary")
  | Next ivl -> fprintf fmt "X@ %a" Interval.format ivl
  | Finally ivl -> fprintf fmt "F@ %a" Interval.format ivl
  | Globally ivl -> fprintf fmt "G@ %a" Interval.format ivl
  | SometimeInThePast ivl -> fprintf fmt "FP@ %a" Interval.format ivl
  | GloballyInThePast ivl -> fprintf fmt "GP@ %a" Interval.format ivl
;;

type binary=
  | And
  | Or
  | Iff
  | Implies
  | Until of Interval.t
  | Release of Interval.t
  | BackTo of Interval.t
  | Since of Interval.t
let format_binary fmt = function
  | And   -> fprintf fmt  "&&"
  | Or   -> fprintf fmt  "||"
  | Iff  -> fprintf fmt  "<=>"
  | Implies -> fprintf fmt "=>"
  | Until  ivl -> fprintf fmt "U@a %a" Interval.format ivl
  | Release  ivl -> fprintf fmt "R@a %a" Interval.format ivl
  | BackTo  ivl -> fprintf fmt "B@a %a" Interval.format ivl
  | Since  ivl -> fprintf fmt "S@a %a" Interval.format ivl

type t=
  |Nullary of nullary
  |Unary of (unary * t)
  |Binary of (binary * t * t);;

let rec format fmt formula=
  match formula with
  | Nullary op -> format_nullary fmt op
  | Unary (Brace,  phi) -> fprintf fmt "@[(%a@])" format phi
  | Unary (op, phi) -> fprintf fmt "@[(%a %a@])" format_unary op format phi
  | Binary (op, phi, chi) -> fprintf fmt "@[(%a@ %a@ %a@])" format phi format_binary op format chi;;

let tru = (Nullary True);;
let fals = (Nullary False);;
