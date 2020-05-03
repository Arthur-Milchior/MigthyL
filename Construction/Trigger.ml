let immediatlyTrue fmt formula =
  fprintf fmt "function immediately_true()@ @[{return %a;@;//Whether the MITL holds simply du to immediate properties.@]}" Atemporal.format
;;
