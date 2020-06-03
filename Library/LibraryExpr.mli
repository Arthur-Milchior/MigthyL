val eq_var_int : Name.var -> int -> Rec.expression;;
  
val satisfiesRightInterval : Name.var -> Interval.t -> Expression.t;;
val satisfiesLeftInterval : Name.var -> Interval.t -> Expression.t;;
val in_interval : Name.var -> Interval.t -> Expression.t list;;

val prop_holds : Name.var -> Expression.st;;
val prop_not_holds : Name.var -> Expression.t;;
val call : ?args:(Rec.expression list) -> Rec.declaration_fun -> Expression.t;;
