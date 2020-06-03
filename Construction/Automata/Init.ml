open LibraryExpr;;
open LibraryAssignmentTransition;;

let template topIndex index triggerVar=
  let
    initVar = Var.local "init"
  in
  let
    transitionInit =
    { select= [];
      guard = [MlType.var initVar];
      assignments = [
          AssignementTransition.Var (initVar, MlType.False);
          LibraryAssignmentTransition.validateTrigger topIndex index
        ];
      comment = None
    }
  and
    transitionNotinit=
    { select= [];
      guard = [prop_not_holds initVar];
      assignments = [
          (* LibraryAssignmentTransition.unvalidateTrigger topIndex index;
           *)];
      comment = None
    }
  in
  { Template.name = "Initial";
    Template.transitions = [transitionInit triggerVar;
                            transitionNotInit prop triggerVar];
    Template.declarations_vars = [];
    Template.declarations_funs = [];
    Template.comment = ""
  }
;;
