open Utils;;
open Format;;
(**An interval, and an index *)
type nullary =
  | True
  | False
  | Prop of Atom.t
  | Prop_neg of Atom.t
  (* | Trigger of Trigger.t *)
;;

let format_nullary fmt = function
  | True  -> fprintf fmt "true"
  | False -> fprintf fmt "false"
  | Prop atom -> Atom.format fmt atom
  | Prop_neg atom-> fprintf fmt "!%a" Atom.format atom
  (* | Trigger atom -> Trigger.format fmt atom *)
;;

type binary=
  | And
  | Or
;;

let format_binary fmt = function
  | And -> fprintf fmt  "&&"
  | Or -> fprintf fmt  "||"
;;

type t =
  |Nullary of nullary
  |Binary of (binary * t * t)
;;
let rec format fmt formula =
  match formula with
  | Nullary op -> format_nullary fmt op
  | Binary (op, phi, chi) -> fprintf fmt "@[(%a@ %a@ %a@])" format phi format_binary op format chi
;;

let tru = Nullary True ;;
let fals = Nullary False ;;

(** Smart constructor for conjonction *)
let andd left right =
  match left, right with
  | Nullary True, _ -> right
  | _, Nullary  True -> left
  | Nullary False, _ | _, Nullary  False -> fals
  | _, _ -> Binary (And, left, right)
;;

(** Smart constructor for disjunction *)
let orr left right =
  match left, right with
  | Nullary False, _ -> right
  | _, Nullary False -> left
  | Nullary True, _ | _, Nullary True -> tru
  | _, _ -> Binary (And, left, right)
;;

(** Set each trigger to false *)
let rec falsify_trigger formula =
  match formula with
  | Nullary (Trigger _) -> fals
  | Nullary _ -> formula
  | Binary (And, left, right) -> andd (falsify_trigger left) (falsify_trigger right)
  | Binary (Or, left, right) -> orr (falsify_trigger left) (falsify_trigger right)
;;

(** negate the formula, with triggers false. Equivalent of ~ in the paper *)
let rec negate_falsify_trigger formula =
  match formula with
  | Nullary (Trigger _) -> tru
  | Nullary (Prop p) -> Nullary (Prop_neg p)
  | Nullary (Prop_neg p) -> Nullary (Prop p)
  | Binary (And, left, right) -> orr (negate_falsify_trigger left) (negate_falsify_trigger right)
  | Binary (Or, left, right) -> andd (negate_falsify_trigger left) (negate_falsify_trigger right)
  | Nullary (True) -> fals
  | Nullary (False) -> tru
;;

let list_triggers formula =
  let rec aux acc = function
    | Binary (_, left, right) -> aux (aux acc left) right
    | Nullary (Trigger t) -> t::acc
    | _ -> acc
  in aux [] formula
;;
