type t = {
  select: Select.ts;
  guard : Guard.t list;
  assignments: Assignment_transition.t list;
  comment: Comment.t;
};;
val format : Format.formatter -> t -> unit;;
