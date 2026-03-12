`timescale 1ns / 1ps

module TopLevelCPU_tb;

    reg clk;
    reg reset_n;
    reg [2:0] reg_select;
    wire [15:0] PC_out;
    wire [15:0] reg_out;
    wire zero_flag;
    wire sign_flag;
    wire [2:0] CU_state;
    wire [15:0] IR_out;

    // Instantiate DUT
    TopLevelCPU dut (
        .clk(clk),
        .reset_n(reset_n),
        .reg_select(reg_select),
        .PC_out(PC_out),
        .reg_out(reg_out),
        .zero_flag(zero_flag),
        .sign_flag(sign_flag),
        .CU_state(CU_state),
        .IR_out(IR_out)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz

    initial begin
        $display("===== TopLevelCPU Simulation Begin =====");

        // Initial state
        reset_n = 0;
        reg_select = 3'b000;

        // Apply reset
        #10 reset_n = 1;

        // Wait for system to initialize and run a few cycles
        #100;

        // ---- reg_select = 000: reg_data1 ----
        reg_select = 3'b000;
        #20;
        $display("reg_select = 000");
        $display("PC_out     = %h", PC_out);
        $display("IR_out     = %h", IR_out);
        $display("reg_out    = %h", reg_out);
        $display("CU_state   = %b", CU_state);
        $display("zero_flag  = %b", zero_flag);
        $display("sign_flag  = %b", sign_flag);

        // ---- reg_select = 001: reg_data2 ----
        reg_select = 3'b001;
        #20;
        $display("reg_select = 001");
        $display("reg_out    = %h", reg_out);

        // ---- reg_select = 010: reg_write_data ----
        reg_select = 3'b010;
        #20;
        $display("reg_select = 010");
        $display("reg_out    = %h", reg_out);

        $display("===== TopLevelCPU Simulation End =====");
        $stop;
    end

endmodule
