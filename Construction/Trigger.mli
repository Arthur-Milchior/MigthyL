(** A function declaration returning whether a parent triggered this
   subformula. *)
val triggerredBySomeParent :
  Parent.t -> Indexed.index -> MlType.declaration
;;

(** A function declaration returning whether the input atemporal formula is immedietely true. *)
val immediatlyTrue :
  Format.formatter -> Atemporal.t -> unit
;;

