`include "refcpu/defs.svh"

module UnsignedArithmetic (
    input  context_t ctx,
    output context_t out
);
    `FORMAT_ITYPE(opcode, rs, rt, imm, ctx.instr);

    word_t sext_imm, zext_imm;
    assign sext_imm = `SIGN_EXTEND(imm);
    assign zext_imm = `ZERO_EXTEND(imm);

    always_comb begin
        out = ctx;
        out.state = S_COMMIT;
        out.target_id = rt;

        unique case (opcode)
        OP_ADDIU:
            out.r[rt] = ctx.r[rs] + sext_imm;
        OP_SLTI:
            out.r[rt] = `SIGNED_CMP(ctx.r[rs], sext_imm);
        OP_SLTIU:
            out.r[rt] = `UNSIGNED_CMP(ctx.r[rs], sext_imm);
        OP_ANDI:
            out.r[rt] = ctx.r[rs] & zext_imm;
        OP_ORI:
            out.r[rt] = ctx.r[rs] | zext_imm;
        OP_XORI:
            out.r[rt] = ctx.r[rs] ^ zext_imm;
        OP_LUI:
            out.r[rt] = {imm, 16'b0};
        default:
            // Decode should guarantee that no other instruction
            // enters this state.
            out.state = S_UNKNOWN;
        endcase
    end
endmodule
