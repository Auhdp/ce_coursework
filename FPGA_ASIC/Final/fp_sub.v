`timescale 1ns / 1ps
module fp_sub (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] result,
    output        zero_flag,
    output        sign_flag,
    output        nan_flag
);
    wire [31:0] neg_b = {~b[31], b[30:0]};
    fp_add add_inst (
        .a(a),
        .b(neg_b),
        .result(result),
        .zero_flag(zero_flag),
        .sign_flag(sign_flag),
        .nan_flag(nan_flag)
    );
endmodule
