(** [ Peer-to-Peer Parallel ]  *)

open Types

let start jid url =
  let _ztx = ZMQ.Context.create () in
  let _addr, _router = Utils.bind_available_addr _ztx in
  let req = ZMQ.Socket.create _ztx ZMQ.Socket.req in
  ZMQ.Socket.connect req url;
  Utils.send req P2P_Reg [|_addr; jid|];
  (* create and initialise part of the context *)
  let _context = Utils.empty_context () in
  _context.job_id <- jid;
  _context.myself_addr <- _addr;
  _context.myself_sock <- _router;
  _context.ztx <- _ztx;
  (* depends on the role, start server or client *)
  let m = of_msg (ZMQ.Socket.recv req) in
  match m.typ with
    | Job_Master -> Paramserver.init m _context
    | Job_Worker -> Paramclient.init m _context
    | _ -> Logger.info "%s" "unknown command";
  ZMQ.Socket.close req
