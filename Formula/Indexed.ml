open Utils;;
open Format;;

type index = int;;

type assoc = [Nnf.t, int];;

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
  | Until  (ivl, _) -> fprintf fmt "U %a" Interval.format ivl
  | Release  (ivl, _) -> fprintf fmt "R %a" Interval.format ivl
  | Since  (ivl, _) -> fprintf fmt "S %a" Interval.format ivl
  | BackTo  (ivl, _) -> fprintf fmt "B %a" Interval.format ivl
;;

type t' =
  |Nullary of nullary
  |Binary of binary * t * t
and t =
  (t' * index)
;;

let rec format fmt (formula, _) =
  match formula with
    |Nullary op -> format_nullary fmt op
    |Unary (op, phi) -> fprintf fmt "%a@ @[(%a@])" format_unary op format_aux phi
    |Binary (op, phi, chi) -> fprintf fmt "@[(%a@])@ %a@ @[(%a@])" format_aux phi format_binary op format_aux chi
;;

let atomic_subformulas =
  let rec aux acc (formula, _) =
    match formula with
    | Binary (_, left, right)-> aux (aux acc left) right
    | Nullary (Prop p)
    | Nullary (Prop_neg p) -> Atom.Set.add p acc
    | Nullary _ -> acc
  in aux Atom.Set.empty;;

let nb_distinct_subformula (formula, idx) =
  idx + 1
;; (* it only works for top level subformula *)
val fals: t;;
