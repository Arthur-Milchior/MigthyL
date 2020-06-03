val var_int: Var.t -> int -> AssignmentTransition.t ;;
val validateTrigger: Indexed.index -> Indexed.index -> AssignmentTransition.t ;;
(* val unvalidateTrigger: Indexed.index -> Indexed.index -> AssignmentTransition.t ;; *)
val validateTemplate: Indexed.index -> AssignmentTransition.t ;;
val unvalidateTemplate: Indexed.index -> AssignmentTransition.t ;;

