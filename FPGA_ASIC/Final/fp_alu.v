`timescale 1ns / 1ps
module fp_alu (
    input [31:0] a,
    input [31:0] b,
    input [1:0] op, // 00 = FADD, 01 = FSUB, 10 = FMUL
    output [31:0] result,
    output zero_flag,
    output sign_flag,
    output nan_flag
);

    // Kết quả trung gian
    wire [31:0] add_result, sub_result, mul_result;
    wire mul_zero, mul_sign, mul_nan;
    wire add_zero, add_sign, add_nan;
    wire sub_zero, sub_sign, sub_nan;

    // Gọi các module toán học
    fp_add u_add (
        .a(a),
        .b(b),
        .result(add_result),
        .zero_flag(add_zero),
        .sign_flag(add_sign),
        .nan_flag(add_nan)
    );

    fp_sub u_sub (
        .a(a),
        .b(b),
        .result(sub_result),
        .zero_flag(sub_zero),
        .sign_flag(sub_sign),
        .nan_flag(sub_nan)
    );

    fp_mul u_mul (
        .flp_a(a),
        .flp_b(b),
        .result(mul_result),
        .zero_flag(mul_zero),
        .sign_flag(mul_sign),
        .nan_flag(mul_nan)
    );

    // Chọn kết quả
    assign result = (op == 2'b00) ? add_result :
                    (op == 2'b01) ? sub_result :
                    (op == 2'b10) ? mul_result :
                    32'b0;

    // Cờ đầu ra
    assign zero_flag = (op == 2'b00) ? add_zero :
                       (op == 2'b01) ? sub_zero :
                       (op == 2'b10) ? mul_zero : 0;

    assign sign_flag = (op == 2'b00) ? add_sign :
                       (op == 2'b01) ? sub_sign :
                       (op == 2'b10) ? mul_sign : 0;

    assign nan_flag  = (op == 2'b00) ? add_nan :
                       (op == 2'b01) ? sub_nan :
                       (op == 2'b10) ? mul_nan : 0;

endmodule
