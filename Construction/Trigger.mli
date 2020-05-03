(** A trigger is a boolean property which indicates that a formulas
   requires one of its subformula to be true immediately. The
   automaton of the subformula will ensure that it is indeed the
   case. It will do so either by ensuring that the formula is
   immediately true, or by changing its variable so that this
   automaton accepts in the future only if the property holds
   immediately. *)
val trigger :
  Format.formatter -> (int, int) -> unit
;;

(** A function declaration returning whether a parent triggered this
   subformula. *)
val triggerredBySomeParent :
  Parent.t -> Format.formatter -> Indexed.index -> MlType.declaration
;;

(** A function declaration returning whether the input atemporal formula is immedietely true. *)
val immediatlyTrue :
  Format.formatter -> Atemporal.t -> unit
;;

(** A function which indicates whether we should really trigger this
   subformula. I.e. whether a parent trigger and the formula is not
   immediately true.*)
val reallyTriggered :
  Format.formatter -> unit -> MlType.declaration
;;
