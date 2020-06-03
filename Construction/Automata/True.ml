open Transition;;

let template =
  let transition = {
      select= [];
      guard = [];
      assignments = [];
      comment = None
    }
  in {
      Template.name = "true";
      Template.transitions = [transition];
      Template.declarations_vars = [];
      Template.declarations_funs = [];
      Template.comment = "This automaton never blocks the run."
    }
;;
