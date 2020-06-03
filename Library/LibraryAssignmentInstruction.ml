open LibraryAssignment;;
open AssignmentTransition;;

let var_int var valu = Var (var_int var valu);;
let validateTrigger parent child = Var (validateTrigger parent child) ;;
(* let unvalidateTrigger parent child = MlType.Pass;; *)
let validateTemplate index = Var (validateTemplate index) ;;
let unvalidateTemplate index = Var (unvalidateTemplate index) ;;

