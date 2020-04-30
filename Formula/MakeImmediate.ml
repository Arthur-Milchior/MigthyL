let translate_nullary = function
  | Indexed.True -> Atemporal.True
  | Indexed.False -> Atemporal.False
  | Indexed.Prop at -> Atemporal.Prop at
  | Indexed.Prop_neg at -> Atemporal.Prop_neg at
;;

let rec translate (formula, _) = match formula with
  | Indexed.Nullary nul -> Atemporal.Nullary (translate_nullary nul)
  | Indexed.Binary (Indexed.And, left, right) ->
      Atemporal.andd (translate left) (translate right)
  | Indexed.Binary (Indexed.Or, left, right)  ->
     Atemporal.orr (translate left) (translate right)
  | Indexed.Binary (Indexed.Until _,_,_)
  | Indexed.Binary (Indexed.Release _,_,_)
  | Indexed.Binary (Indexed.Singe _,_,_)
  | Indexed.Binary (Indexed.BackTo _,_,_)
    ->
     Atemporal.Nullary (Atemporal.False)
;;
