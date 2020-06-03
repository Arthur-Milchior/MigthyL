open LibraryAssignment;;

let var_int var valu = Assign (var_int var valu);;
let validateTrigger parent child = Assign (validateTrigger parent child) ;;
let unvalidateTrigger parent child = MlType.Pass;;
let validateTemplate index = Assign (validateTemplate index) ;;
let unvalidateTemplate index = Assign (unvalidateTemplate index) ;;

