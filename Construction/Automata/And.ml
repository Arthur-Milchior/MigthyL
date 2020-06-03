open Template;;
open Trigger;;
     
let template index indexLeft indexRight triggerVar=
  let
    name = Printf.sprintf "phi_%d = phi_%d /\\ phi_%d" index indexLeft indexRight
  and
    transition_trigger = {
      select= [];
      guard = ["really_triggered();"];
      assignments = [
          Printf.sprintf "%s = really_triggered();" (trigger indexLeft);
          Printf.sprintf "%s = really_triggered();" (trigger indexRight);
        ];
      comment = "Disjunction propagates trigger to its children"
    }
  and
    transition_no_trigger = {
      select= [];
      guard = ["!really_triggered();"];
      assignments = [
        ];
      comment = "Trigger is not pulled, so it does not pull its children."
    }
  in {
      name = name;
      transitions = [
          transition_trigger;
          transition_no_trigger;
        ];
      declarations = [] ;
      comment = ""
    }
;;
