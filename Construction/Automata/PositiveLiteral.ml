open Template;;

let template index prop =
  let
    name = "Property "^prop
  and
    transitionTrigger = {
      select= [] ;
      guard = [
          "!"^(Property.prop_neg prop) ;
          Trigger.trigger index;
        ];
      assignments = [(Property.prop prop)^" = true"];
      comment = "The trigger is pulled. We must ensure that the trigger of the negation is not pulled too. We do this by ensuring that at most one of the proposition and its negation holds during this cycle over each subformula.";
    }
  and
    transitionNoTrigger = {
      select= [];
      guard = ["!"^Trigger.trigger index];
      assignments = [];
      comment = "The trigger is not pulled, so the transition is automatically accepted."
  }
    in
  { Template.name = name;
    Template.transitions = [transitionTrigger;
                            transitionNoTrigger];
    Template.declarations_vars = [];
    Template.declarations_funs = [];
    Template.comment = Printf.sprintf "Each time the trigger is called, the atomic property %s should immediatly hold." prop
  }
;;
