open Lwt.Infix
open Cohttp_lwt_unix

let main () =
  Lwt.catch
    (fun () -> Cohttp_lwt_unix.Client.get (Uri.of_string "http://www.google.com"))
    (fun exn -> Lwt.fail exn) >>= fun (resp, body) ->
  Printf.printf "OK\n" ;
  Lwt.return_unit

let () = Lwt_main.run (main ())
