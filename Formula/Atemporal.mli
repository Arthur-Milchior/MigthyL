(** The atomic formulas *)
type nullary =
  | True
  | False
  | Prop of Atom.t
  | Prop_neg of Atom.t
  (* | Trigger of Trigger.t *)
;;
(** The binary operators *)
type binary=
  | And
  | Or
;;

(** the type of formula as in the input *)
type t =
  |Nullary of nullary
  |Binary of (binary * t * t) ;;
val format : Format.formatter -> t -> unit ;;
(** the formula true *)
val tru : t ;;
(** the formula false *)
val fals : t ;;
(** Smart constructor for conjonction. It simplifies formulas which are trivial to simplify. I.e. with False or True as direct subformula.*)
val andd : t -> t -> t ;;
(** Smart constructor for disjunction. Same remark than for andd *)
val orr : t -> t -> t ;;
(** Set each trigger to false *)
val falsify_trigger : t -> t ;;
(** negate the formula, with triggers false. Equivalent of ~ in the paper *)
val negate_falsify_trigger : t -> t ;;

(** the list of triggers in the formula *)
val list_triggers : t -> Trigger.t list ;;
