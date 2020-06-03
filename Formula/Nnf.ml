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
    | Binary (op, phi, chi) -> fprintf fmt "@[(%a@])@ %a@ @[(%a@])" format_aux phi format_binary op format_aux chi
;;


let atoms formula =
  let rec aux (pos, neg) = (
      function
      | Nullary (Prop at) -> (Atom.set.add pos at, neg)
      | Nullary (Prop_neg at) -> (pos, Atom.set.add neg at)
      | Binary (op, phi, psi) -> aux phi (aux psi (pos, neg))
      | Nullary _ -> (pos, neg)
    )
  in aux (Atom.Set.empty, Atom.Set.empty) formula
;;

(** Replace atoms which appear with a single polarity (always negated
   or never negated) by true.

The intuition behind it is that if an atom always appear
   positively/negatively, the formula is satisfiable iff it is
   satisfiable with this atom being true/false. Since we want to
   consider satisfiability of formulas, setting it to true does not
   lose generality. It then allow to ensure that each atom has a
   negation somewhere in the formula.*)
let unipolarityToTrue formula =
  let pos, neg = atoms formula in
  let rec aux formula = match formula with
    | Nullary (Prop at) ->
       if Atom.Set.mem at neg
       then formula
       else Nullary True
    | Nullary (Prop_neg at) ->
       if Atom.Set.mem at pos
       then formula
       else Nullary True
    | Nullary _ -> formula
    | Binary (op, phi, psi) ->
       Binary (op, aux phi, aux psi)
;;
