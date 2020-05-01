type t = Indexed.t array;;

let precompute formula_ =
  let ar = Array.make (Indexed.nb_distinct_subformula formula_) [Indexed.fals] in
  let rec aux (formula, idx) as formula_ =
    if ar.(idx) != Indexed.fals then
      ((match formula with
      | Indexed.binary (bin, phi, psy) ->
         aux phi;
         aux psy);
       ar.(idx) <- formula_);
  in
  aux formula_;
  ar
;;

let subformulas =
  array_to_list
;;

let indexToSubformula subformulas index  =
  subformulas.(index)
;;
