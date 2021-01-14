`include "refcpu/Defs.svh"

module FetchAddrSent (
    input  context_t   ctx,
    output context_t   out,
    output ibus_req_t  ireq,
    input  ibus_resp_t iresp
);
    assign ireq.valid = '0;     // stop issuing request
    assign ireq.addr = ctx.pc;  // for debugging

    always_comb begin
        out = ctx;
        out.t[0] = iresp.data;
        out.state = iresp.data_ok ? S_DECODE : S_FETCH_ADDR_SENT;
    end

    logic _unused_ok = &{iresp.addr_ok};
endmodule