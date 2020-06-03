(** set variable var to inteer i *)
let var_int var i=
  {
    MlType.assignment_var = MlType.Var_left var;
    MlType.expression = MlType.Int i;
  };;

(** State that parent triggers child **)
let validateTrigger parent child =
  (* MlType.Assign {MlType.assignment_var = Var.from_trigger_pair parent child;
   *                MlType.expression = MlType.True}; *)
  {MlType.assignment_var = MlType.Var_left (Var.from_trigger_solo child);
   MlType.expression = MlType.True
  };
  
(** State that parent does not trigger child **)
let unvalidateTrigger parent child =
  (* MlType.Assign {MlType.assignment_var = Var.from_trigger_pair parent child;
   *                MlType.expression = MlType.False}; *)
  MlType.Pass
  
(** State that the condition for this template are accepting or not according to value **)
let un_validateTemplate value index =
  {MlType.assignment_var = MlType.Var_left (Var.accept_subformula index);
   MlType.expression = value}
;;

(** State that the condition for this template are accepting**)
let unvalidateTemplate =
  un_validateTemplate  MlType.False
;;

(** State that the condition for this template are not accepting**)
let validateTemplate =
  un_validateTemplate  MlType.True
;;

let increase var =
  {MlType.assignment_var = MlType.Var_left var;
   MlType.expression = MlType.Bin_op (var, MlType.Add, MlType.Int 1)}
;;
let decrease var =
  {MlType.assignment_var = MlType.Var_left var;
   MlType.expression = MlType.Bin_op (var, MlType.Minus, MlType.Int 1)}
;;
    
let accept index =
  {MlType.assignment_var = MlType.Var_left (Var.accept_subformula index);
   MlType.expression = MlType.True}
;;
let reject index =
  {MlType.assignment_var = MlType.Var_left (Var.accept_subformula index);
   MlType.expression = MlType.False}
;;
  
