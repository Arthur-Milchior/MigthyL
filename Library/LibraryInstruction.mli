val var_int: Var.t -> int -> MlType.instruction ;;
val validateTrigger: Indexed.index -> Indexed.index -> MlType.instruction ;;
val unvalidateTrigger: Indexed.index -> Indexed.index -> MlType.instruction ;;
val validateTemplate: Indexed.index -> MlType.instruction ;;
val unvalidateTemplate: Indexed.index -> MlType.instruction ;;

