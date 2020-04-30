type typ =
	| General
	| Upper (** Unbounded above*)
	| Lower (** Starting at [0*)
	| Untimed (** Equivalently: 0 to infty*)

(** The type of intervals. left and right bounds are integer. They are closed if lc (respectively, rc) are True, and open otherwise. 

cover is the number of interval of this size, required to cover, from 0 to the right part of this actual interval. 
Note that, formally, such a cover potentially omitting a finite number of point when the interval is open lc=rc=False and furthermore, the size divide the left bound of the interval. 

typ state which kind of interval it is.

cover and typ are redundant informations.
*)
type t =
  {
    typ: typ;
    l:int;
    lc:bool;
    r:int;
    rc:bool;
    cover : int;
  }
;;
val format : Format.formatter -> t -> unit;;
val format_option : Format.formatter -> t option -> unit;;

(** create an interval, given left bound and right bound. Boolean state whether this bound is closed *)
val create : int -> bool -> int-> bool -> t;;
