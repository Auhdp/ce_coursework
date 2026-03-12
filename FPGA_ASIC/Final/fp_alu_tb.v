`timescale 1ns / 1ps
module fp_alu_tb;

    reg [31:0] a, b;
    reg [1:0] op;
    wire [31:0] result;
    wire zero_flag, sign_flag, nan_flag;

    fp_alu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .zero_flag(zero_flag),
        .sign_flag(sign_flag),
        .nan_flag(nan_flag)
    );

    task show_result;
        begin
            $display("Time: %0t ns", $time);
            $display("  op     = %02b", op);
            $display("  a      = %h", a);
            $display("  b      = %h", b);
            $display("  result = %h", result);
            $display("  zero   = %b, sign = %b, nan = %b", zero_flag, sign_flag, nan_flag);
            $display("-----------------------------");
        end
    endtask

    initial begin
        $display("# ===== FP ALU IEEE-754 TEST BEGIN =====");

        // FADD: 1.5 + 2.25 = 3.75
        op = 2'b00; a = 32'h3fc00000; b = 32'h40100000; #10; show_result();

        // FADD: -1.0 + 1.0 = 0
        a = 32'hbf800000; b = 32'h3f800000; #10; show_result();

        // FSUB: 3.5 - 1.5 = 2.0
        op = 2'b01; a = 32'h40600000; b = 32'h3fc00000; #10; show_result();

        // FSUB: 1.5 - 2.5 = -1.0
        a = 32'h3fc00000; b = 32'h40200000; #10; show_result();

        // FMUL: 1.5 * 2.0 = 3.0
        op = 2'b10; a = 32'h3fc00000; b = 32'h40000000; #10; show_result();

        // FMUL: 0.0 * 5.0 = 0.0
        a = 32'h00000000; b = 32'h40a00000; #10; show_result();

        // FMUL: Inf * 1.0 = Inf
        a = 32'h7f800000; b = 32'h3f800000; #10; show_result();

        // FMUL: NaN * 1.0 = NaN
        a = 32'h7fc00001; b = 32'h3f800000; #10; show_result();

        $display("# ===== FP ALU IEEE-754 TEST END =====");
        $finish;
    end
endmodule
