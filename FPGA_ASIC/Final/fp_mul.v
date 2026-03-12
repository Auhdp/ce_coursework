`timescale 1ns / 1ps
module fp_mul (
    input [31:0] flp_a,
    input [31:0] flp_b,
    output reg [31:0] result,
    output reg zero_flag,
    output reg sign_flag,
    output reg nan_flag
);
    reg sign;
    reg [7:0] exp_a, exp_b, exp_res;
    reg [23:0] mant_a, mant_b;
    reg [47:0] mant_mult;
    reg [22:0] mantissa;
    integer i;

    always @(*) begin
        zero_flag = 0; sign_flag = 0; nan_flag = 0;
        result = 32'b0;

        // Special case: Zero
        if (flp_a[30:0] == 0 || flp_b[30:0] == 0) begin
            result = {flp_a[31] ^ flp_b[31], 31'b0};
            zero_flag = 1;
            sign_flag = flp_a[31] ^ flp_b[31];
        end
        // Special case: NaN or INF
        else if (flp_a[30:23] == 8'hFF || flp_b[30:23] == 8'hFF) begin
            if ((flp_a[30:23] == 8'hFF && flp_a[22:0] != 0) ||
                (flp_b[30:23] == 8'hFF && flp_b[22:0] != 0) ||
                (flp_a[30:23] == 8'hFF && flp_b[30:23] == 0) ||
                (flp_b[30:23] == 8'hFF && flp_a[30:23] == 0)) begin
                result = 32'h7FC00001; // NaN
                nan_flag = 1;
            end else begin
                result = {flp_a[31] ^ flp_b[31], 8'hFF, 23'b0}; // ±Infinity
                sign_flag = flp_a[31] ^ flp_b[31];
            end
        end
        else begin
            // Extract parts
            sign = flp_a[31] ^ flp_b[31];
            exp_a = flp_a[30:23];
            exp_b = flp_b[30:23];
            mant_a = {1'b1, flp_a[22:0]};
            mant_b = {1'b1, flp_b[22:0]};

            mant_mult = mant_a * mant_b;
            exp_res = exp_a + exp_b - 127;

            if (mant_mult[47]) begin
                mantissa = mant_mult[46:24];
                exp_res = exp_res + 1;
            end else begin
                mantissa = mant_mult[45:23];
            end

            result = {sign, exp_res, mantissa};
            sign_flag = sign;
            zero_flag = (result[30:0] == 0);
        end
    end
endmodule
