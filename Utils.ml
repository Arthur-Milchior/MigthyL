let rec range n =
  let l = ref [] in
  for i=0 to i-1 do
    l := (n-i-1) :: !l
  done
    !l;;
