`include "common.svh"

import common::*;

module DCache (
    input logic clk, resetn,

    input  dbus_req_t  dreq,
    output dbus_resp_t dresp,
    output cbus_req_t  creq,
    input  cbus_resp_t cresp
);
    /**
     * TODO (Lab3) your code here :)
     */

    // remove following lines when you start
    assign {dresp, creq} = '0;
    logic _unused_ok = &{clk, resetn, dreq, cresp};
endmodule
