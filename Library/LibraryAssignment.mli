val var_int: Var.t -> int -> MlType.assignment ;;
val validateTrigger: Indexed.index -> Indexed.index -> MlType.assignment ;;
(* val unvalidateTrigger: Indexed.index -> Indexed.index -> MlType.assignment ;; *)
val validateTemplate: Indexed.index -> MlType.assignment ;;
val unvalidateTemplate: Indexed.index -> MlType.assignment ;;
val increase : Var.t -> MlType.assignment;;
val decrease : Var.t -> MlType.assignment;;
val accept : Indexed.index -> MlType.assignment;;
val reject : Indexed.index -> MlType.assignment;;
