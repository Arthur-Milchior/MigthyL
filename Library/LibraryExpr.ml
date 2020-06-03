let eq_var_int var i=
   MlType.Bin_op(MlType.Eq, MlType.Var var, MlType.Int i);;

let in_interval x interval =
  let left_bound =
    MlType.Bin_op (
      (if interval.Interval.lc then MlType.Ge else MlType.Gt),
      MlType.Var x,
      MlType.Int interval.Interval.l
    );
  in
  if interval.Interval.r == max_int
  then [left_bound]
  else [
    MlType.Bin_op (
      (if interval.Interval.lc then MlType.Le else MlType.Lt),
      MlType.Var x,
      MlType.Int interval.Interval.r);
    left_bound
  ];;

let satisfiesLeftInterval x interval=
  MlType.Bin_op (
    (if interval.Interval.lc then MlType.Ge else MlType.Gt),
    MlType.Var x,
    MlType.Int interval.Interval.l);;

let satisfiesRightInterval x interval =
  MlType.Bin_op (
    (if interval.Interval.lc then MlType.Le else MlType.Lt),
    MlType.Var x,
    MlType.Int interval.Interval.r);;


let prop_holds var =
  MlType.Var var;;
    
let prop_not_holds var =
  MlType.Prefix_operator(MlType.Not,MlType.Var var);;

let call ?(args=[]) func =
  MlType.Expression_func (func,args);;
