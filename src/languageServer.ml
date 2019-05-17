let oc = open_out_gen [Open_append; Open_creat] 0o666 "ls.log"
let log_to_file txt =
    Printf.fprintf oc "%s\n" txt;
    flush oc

let respond out =
  let cl = "Content-Length: " ^ string_of_int (String.length out) ^ "\r\n\r\n" in
  print_string cl;
  print_string out;
  flush stdout;
  log_to_file "Response:";
  log_to_file cl;
  log_to_file out

let start () =
  let rec loop () =
    let clength = read_line () in
    log_to_file "Request:";
    log_to_file clength;
    let cl = "Content-Length: " in
    let cll = String.length cl in
    let num =
      (int_of_string
        (String.trim
           (String.sub
              clength
              cll
              (String.length(clength) - cll - 1)))) + 2 in
    let buffer = Buffer.create num in
    Buffer.add_channel buffer stdin num;
    let raw = Buffer.contents buffer in
    log_to_file raw;

    let json = Yojson.Basic.from_string raw in

    let json2 = Lsp2_j.incoming_message_of_string raw in
    let jsonrpc = json2.Lsp2_t.incoming_message_jsonrpc in
    (* let method_ = Lsp2_j.string_of_incoming_message_method json2.Lsp2_t.incoming_message_method in *)
    (* log_to_file ("jsonrpc: " ^ jsonrpc ^ ", method: " ^ method_); *)
    log_to_file ("jsonrpc: " ^ jsonrpc);

    let received = LSP.parse json in

    let string_of_int_option =
      function
      | None -> "None"
      | Some i -> string_of_int i in

    log_to_file (string_of_int_option received.LSP.id ^ ", " ^ received.LSP.method_);

    if received.LSP.method_ = "initialize"
      then begin
        log_to_file "Handle initialize";
        let capabilities = `Assoc
          [ ("textDocumentSync", `Null)
          ] in
        let result = `Assoc
          [ ("capabilities", capabilities)
          ] in
        let response = LSP.response received.LSP.id result `Null in
        respond (Yojson.Basic.pretty_to_string response);
      end

    else if received.LSP.method_ = "initialized"
      then begin
        log_to_file "Handle initialized";
        let notification = LSP.notification "window/showMessage"
          [ ("type", `Int 3)
          ; ("message", `String "Language server initialized")
          ] in
        respond (Yojson.Basic.pretty_to_string notification);
      end

    else
      loop ();

    loop ()
  in loop ()
