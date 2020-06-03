open Transition;;

let template =
  let transition = {
      select= [];
      guard = ["!triggered_by_some_parent()"];
      assignments = [];
      comment = None
    }
  in {
      Template.name = "False";
      Template.transitions = [transition];
      Template.declarations_vars = [];
      Template.declarations_funs = [];
      Template.comment = "If at some point this trigger is pulled, the run ends."
    }
;;
