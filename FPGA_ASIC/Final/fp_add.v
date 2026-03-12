`timescale 1ns / 1ps
module fp_add (
    input  [31:0] a,
    input  [31:0] b,
    output reg [31:0] result,
    output wire zero_flag,
    output wire sign_flag,
    output wire nan_flag
);
    reg sign_a, sign_b, sign_res;
    reg [7:0] exp_a, exp_b, exp_res;
    reg [23:0] mant_a, mant_b, mant_res;
    reg [7:0] exp_diff;
    integer i;

    always @(*) begin
        sign_a = a[31];
        sign_b = b[31];
        exp_a = a[30:23];
        exp_b = b[30:23];
        mant_a = {1'b1, a[22:0]};
        mant_b = {1'b1, b[22:0]};

        if (exp_a > exp_b) begin
            exp_diff = exp_a - exp_b;
            mant_b = mant_b >> exp_diff;
            exp_res = exp_a;
        end else begin
            exp_diff = exp_b - exp_a;
            mant_a = mant_a >> exp_diff;
            exp_res = exp_b;
        end

        if (sign_a == sign_b) begin
            mant_res = mant_a + mant_b;
            sign_res = sign_a;
        end else begin
            if (mant_a >= mant_b) begin
                mant_res = mant_a - mant_b;
                sign_res = sign_a;
            end else begin
                mant_res = mant_b - mant_a;
                sign_res = sign_b;
            end
        end

        if (mant_res == 0) begin
            result = 32'b0;
        end else begin
            for (i = 0; i < 23; i = i + 1)
                if (mant_res[23] == 0) begin
                    mant_res = mant_res << 1;
                    exp_res = exp_res - 1;
                end
            result = {sign_res, exp_res, mant_res[22:0]};
        end
    end

    assign zero_flag = (result[30:0] == 0);
    assign sign_flag = result[31];
    assign nan_flag  = (result[30:23] == 8'hFF && result[22:0] != 0);
endmodule
