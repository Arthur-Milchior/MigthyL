
type t = {
    select: Select.ts; (* List of non-deterministic choice to take during this transition. *)
    guard : Guard.t list; (* List of conditions this transition should satisfy. *)
    assignments: AssignmentTransition.t list; (* Assignments of
                                                 variables; directly
                                                 and by function
                                                 call. *)
    comment: Comment.t option; (* An explanation of this transition *)
};;

let format fmt transition =
  fprintf fmt "@[<v 1><transition>@,";
  fprintf fmt "@[<v 1><source ref=\"%\"/>@]@," Location.format_id Location.default;
  fprintf fmt "@[<v 1><target ref=\"%a\"/>@]@," Location.format_id Location.default;
  Select.formats fmt transition.select;
  Guard.formats fmt transition.guard;
  AssignmentTransition.formats fmt transition.assignments;
  match transition.comment with
  | Some comment ->  Comment.format fmt comment;
  fprintf fmt "@]</transition>@,"
;;
