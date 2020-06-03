open LibraryExpr;;
open LibraryAssignmentTransition;;


let template index interval indexLeft indexRight triggerVar=
  let
    name = Printf.sprintf "phi_%d = phi_%d R_%a phi_%d" index indexLeft Interval.format ivl indexRight
  in

  
  let
    nbClocks = match interval.typ with
    | Interval.General -> 2*interval.cover
    | Interval.Untimed -> 0
    | Interval.Upper | Interval.Lower -> 1
  in
  
  (* working on variables *)
  (** C-expression giving the position of clock clock_pos in the array
     of clocks *)
  let clock_exact_pos clock_pos =
    "(" ^ clock_pos ^ ") % " ^ nbClock
  in
  (** C-expression accessing clock clock_pos *)
  let access_clock clock_pos =
    c_clock ^ "[" ^ clock_exact_pos clock_pos ^ "]"
  in
  let
    (** C-expression stating whether a clock is currently used  *)
    non_empty = "nb_used_clock > 0" 
  and
    (** C-expression stating whether no clock is currently used  *)
    is_empty = "nb_used_clock == 0" 
  in
  (** position of the last clock currently used *)
  let last_clock =
    "first_clock + nb_used_clock - 1"
  in
  (** C-expression for the last clock currently used *)
  let access_last_clock = access_clock last_clock
  (** C-expression for the first clock currently used *)
  and access_first_clock = access_clock "first_clock"
  in
  let restart_last_clock =
    access_last_clock ^ ":= 0;"
  and increase_nb_used_clock =
    "nb_used_clock = nb_used_clock + 1;"
  and increase_first_clock =
    "first_clock = first_clock + 1"
  and decrease_nb_used_clock =
    "nb_used_clock = nb_used_clock - 1;"
  in
  let pop_first_clock =
    "{\n  " ^decrease_nb_used_clock ^ "\n  " ^ increase_first_clock ^ " \n }"
  in

  (* functions *)
  
  let functRemoves =
    Printf.sprintf
      "\
/*Remove the first two clocks, because they represents an obligation which trivially holds. Decrease the automaton number so that this automaton get executed again and do another action*/@;\
function removesFirstObligation()@ @[{\
  %s@;\
  %s@;\
  automate_number@ -=@ 1;\
]}" pop_first_clock pop_first_clock
  and functExtends =
    Printf.sprintf
      "\
/* If an obligation can still be extended, do it.*/\
/* whether psy2 must be triggered */\
function extendsObligationIfNecessary(bool %s)@ @[{\
  if@ @[(%s@ &&@ %s@ %s@ %d@ &&@ %s@ %s@ %d@]) @[{\
    /*We are in an obligation*/\
    @ %s = true; \
  @]}@;\
  /* whether psi1 can be triggered */\
  if@ @[(%s@])@[{\
    %s@ =@ true;@;\
    %s@ =@ 0;@;\
    %s@ =@ 0;\
  @]}@;\
  if@ @[(really_triggered()@])@ @[{\
    /* Trigger is now pulled. New obligation should be created */ \
    if@ @[(%s@ &&@ %s@ %s@ %d@])@ @[{\
      /* Last obligation can be extended */\
      %s
  @]} else @[{
      /* Last obligation can not be extended */\    
       %s@;%s@;%s@;%s@;
  @]}\
  if@ @[(!%s@])@ @[{\
    accept = false;
  @]}\
]}" "trigger_left" non_empty access_first_clock (if interval.lc then ">=" else ">") interval.l (access_clock ("first_clock + 1")) (if interval.rc then "<=" else "<") interval.r (Trigger.trigger indexRight) "trigger_left" (Trigger.trigger indexLeft) "nb_used_clock" "first_clock" non_empty access_last_clock (if interval.lc && interval.rc then "<=" else "<") (interval.r - interval.l) restart_last_clock increase_nb_used_clock restart_last_clock increase_nb_used_clock restart_last_clock empty;
  (* declarations *)
  and declarations_vars = [
      Printf.sprintf "int[0,%d]@ first_clock@ =@ 0;" (nbClock-1);
      Printf.sprintf "/*Number of clocks currently used*/\nint[0,%d]@ nb_used_clock@ =@ 0;" nbClock;
      Printf.sprintf "clock@ %s[%d];" c_clock nbClock;
      functExtends;
      functRemoves;
    ]
  in

  (* transitions *)
  
  let remove_first_interval_transition =
    {select : [];
     guard = [
         non_empty;
         Printf.sprintf "%s %s %d" (access_clock "first_clock + 1") (if interval.rc then ">" else ">=") interval.r
       ];
     assignments = ["removesFirstObligation();"];
     comment = "First interval is passed; thus we can remove it. This will run this automaton again"}
  and no_obligation_transition = {
      select = [];
      guard = [
          is_empty;
        ];
      assignments = [
          "extendsObligationIfNecessary(false);";
        ];
      comment = "No obligation";
    }
  and first_obligation_not_ended_transition  = {
      select = [("trigger_left", Type.Bool)];
      guard = [
          non_empty;
          Printf.sprintf "%s %s %d" (access_clock "first_clock + 1") (if interval.rc then "<=" else "<") interval.r
        ];
      assignments = ["extendsObligationIfNecessary(trigger_left);";];
      comment = "Not yet in first obligation.";
    }
  in
  { name = name ;
    transitions = [first_obligation_not_ended_transition; no_obligation_transition; remove_first_interval_transition];
    declarations = declarations;
    comment = ""
  }
;;
