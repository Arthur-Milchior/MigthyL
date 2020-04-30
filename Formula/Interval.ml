open Format;;
open Utils;;

exception SingularInterval;;
exception EmptyInterval;;
exception RightLeftInversed;;
exception ClosedInfinity;;

type typ =
  | General
  | Upper (** Unbounded above*)
  | Lower (** Starting at [0*)
  | Untimed (** Equivalently: 0 to infty*)
;;

type t =
  {
    typ: typ;
    l: int;
    lc: bool;
    r: int;
    rc: bool;
    cover : int;
  }
;;

let create l lc r rc =
  (* Utils.debug "l=%d, lc=%B, r=%d, rc=%B\n" l lc r rc; *)

  let left0 = lc && l==0
  and rightInfty = r==max_int
  and cover= int_of_float (ceil ((float_of_int r) /. (float_of_int (r - l))))
  in
  let typ =
    match left0, rightInfty with
    |true, true -> Untimed
    |true, false -> Upper
    |false, true -> Lower
    |false, false -> General
  in
  if rightInfty && rc then raise ClosedInfinity;
  if l > 0 && r == l then raise SingularInterval;
  if r < l then raise RightLeftInversed;
  if r == 0 && not rc  then raise EmptyInterval;
  {l = l;
   r = r;
   lc = lc;
   rc = rc;
   cover = cover;
   typ = typ;
  }
;;

let string_of_interval itv =
  (if itv.lc then "[" else "(") ^
    (string_of_int itv.l) ^
      ", " ^
        (if itv.r = max_int then "infty" else string_of_int itv.r) ^
          (if itv.rc then "] " else ") ")
;;

let string_of_interval_option=
  function
  | Some ivl -> string_of_interval ivl
  | None -> ""
;;

let format fmt itv=
  fprintf fmt "%s"(string_of_interval itv)
;;

let format_option fmt itv=
  fprintf fmt "%s"(string_of_interval_option itv)
;;

