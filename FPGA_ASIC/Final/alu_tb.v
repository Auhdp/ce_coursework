`timescale 1ns/1ps

module alu_tb;
    reg  [31:0] a, b;
    reg  [3:0]  alu_op;
    wire [31:0] result;
    wire        zero_flag;
    wire        sign_flag;

    alu dut (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result),
        .zero_flag(zero_flag),
        .sign_flag(sign_flag)
    );

    task show_result;
        begin
            $display("Time: %0t ns", $time);
            $display("  alu_op = %b (%0d)", alu_op, alu_op);
            $display("  a      = %h (%0d)", a, a);
            $display("  b      = %h (%0d)", b, b);
            $display("  result = %h (%0d)", result, result);
            $display("  zero   = %b, sign = %b", zero_flag, sign_flag);
            $display("-----------------------------");
        end
    endtask

    initial begin
        $display("===== ALU TEST BEGIN =====");

        // ADD
        alu_op = 4'b0000; a = 32'd10; b = 32'd5;     #10; show_result();
        alu_op = 4'b0000; a = 32'd2;  b = -32'd2;    #10; show_result();

        // SUB
        alu_op = 4'b0001; a = 32'd10; b = 32'd5;     #10; show_result();
        alu_op = 4'b0001; a = 32'd5;  b = 32'd5;     #10; show_result();

        // AND
        alu_op = 4'b0010; a = 32'hF0F0F0F0; b = 32'h0F0F0F0F; #10; show_result();

        // OR
        alu_op = 4'b0011; a = 32'hF0000000; b = 32'h0000F000; #10; show_result();

        // XOR
        alu_op = 4'b0100; a = 32'hFF00FF00; b = 32'h00FF00FF; #10; show_result();

        // SHIFT LEFT
        alu_op = 4'b0101; a = 32'h00000001; b = 32'd4;        #10; show_result();
        alu_op = 4'b0101; a = 32'h00000001; b = 32'd31;       #10; show_result();
        alu_op = 4'b0101; a = 32'h00000001; b = 32'd40;       #10; show_result(); // Edge case

        // SHIFT RIGHT
        alu_op = 4'b0110; a = 32'h80000000; b = 32'd1;        #10; show_result();
        alu_op = 4'b0110; a = 32'hFFFFFFFF; b = 32'd4;        #10; show_result();

        // ARITHMETIC SHIFT RIGHT
        alu_op = 4'b0111; a = -32'd16; b = 32'd2;             #10; show_result();
        alu_op = 4'b0111; a =  32'd16; b = 32'd2;             #10; show_result();


        $display("===== ALU TEST END =====");
        $stop;
    end
endmodule
