open Template;;
open Trigger;;
     
let template index indexLeft indexRight triggerVar=
  let
    name = Printf.sprintf "phi_%d = phi_%d \\/ phi_%d" index indexLeft indexRight
  and
    transition_left = {
      select= [];
      guard = ["really_triggered();"];
      assignments = [
          Printf.sprintf "%s = really_triggered();" (trigger indexLeft);
        ];
      comment = "Disjunction propagates trigger to its left child only"
    }
  and
    transition_right = {
      select= [];
      guard = ["really_triggered();"];
      assignments = [
          Printf.sprintf "%s = really_triggered();" (trigger indexRight);
        ];
      comment = "Disjunction propagates trigger to its right child only"
    }
  and
    transition_no = {
      select= [];
      guard = ["!really_triggered();"];
      assignments = [
        ];
      comment = "Trigger is not pulled, so it does not pull its children."
    }
  in {
      name = name;
      transitions = [
          transition_left;
          transition_right;
          transition_no
        ];
      declarations = [] ;
      comment = ""
    }
;;
