open Template;;

let rec reset atoms nb_subformula =
  {
    name: "Reset all variables";
    transitions : [
        {
          Transition.select: [];
          Transition.guard : [];
          Transition.assignments:
            List.flatten [
                List.map (fun i -> Trigger.trigger i ^ " = false;") (Utils.range nb_subformula);
                List.map (fun prop -> Property.prop prop ^ " = false;");
                List.map (fun prop -> Property.prop_neg prop ^ " = false;");
                ["accept = true;"]
              ]
          Transition.comment: "";
        }
      ] ;
    declarations: "" ;
    comment : "Put all variables back to false" ;
  }
;;
  
  
;;
