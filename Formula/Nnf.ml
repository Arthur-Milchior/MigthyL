open Utils;;
open Format;;

type nullary =
  | True
  | False
  | Prop of Atom.t
  | Prop_neg of Atom.t
;;
let format_nullary fmt = function
  | True  -> fprintf fmt "true"
  | False -> fprintf fmt "false"
  | Prop atom -> Atom.format fmt atom
  | Prop_neg atom-> fprintf fmt "!%a" Atom.format atom
;;

type binary=
  | And
  | Or
  | Until of Interval.t
  | Release of Interval.t
  | BackTo of Interval.t
  | Since of Interval.t
;;
let format_binary fmt = function
  | And -> fprintf fmt  "&&"
  | Or -> fprintf fmt  "||"
  | Until  ivl -> fprintf fmt "U %a" Interval.format ivl
  | Release  ivl -> fprintf fmt "R %a" Interval.format ivl
  | Since  ivl -> fprintf fmt "S %a" Interval.format ivl
  | BackTo  ivl -> fprintf fmt "B %a" Interval.format ivl
;;

type t =
  | Nullary of nullary
  | Binary of binary * t * t
;;

let rec format fmt formula =
  match formula with
    | Nullary op -> format_nullary fmt op
    | Unary (op, phi) -> fprintf fmt "%a@ @[(%a@])" format_unary op format_aux phi
    | Binary (op, phi, chi) -> fprintf fmt "@[(%a@])@ %a@ @[(%a@])" format_aux phi format_binary op format_aux chi
;;
