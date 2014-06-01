open Debian
open ExtLib

let main () =
  List.iter (fun line ->
      let ver1, ver2 = String.split line "\t" in
      let ret = Version.compare ver1 ver2 in
      print_char (if ret > 0 then '>' else if ret < 0 then '<' else '=')
    ) (Std.input_list stdin);
;;

main ();;
