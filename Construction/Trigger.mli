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
