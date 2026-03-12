`timescale 1ns/1ps

module top_module_tb;

    reg CLOCK_50;
    reg [2:0] KEY;
    reg [7:0] SW;
    wire [6:0] HEX0, HEX1, HEX4, HEX5;

    // Instantiate your top module
    top_module uut (
        .CLOCK_50(CLOCK_50),
        .KEY(KEY),
        .SW(SW),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX4(HEX4),
        .HEX5(HEX5)
    );

    // Clock generation
    initial begin
        CLOCK_50 = 0;
        forever #10 CLOCK_50 = ~CLOCK_50; // 50MHz clock ~ 20ns period
    end

    // Stimulus
    initial begin
        // Reset
        KEY[0] = 0;
        KEY[1] = 1;
        KEY[2] = 1;
        #50;
        KEY[0] = 1; // Release reset

        // Load data
        SW = 8'hAA; // Data = 0xAA
        KEY[1] = 0; // Press load_enable
        #20;
        KEY[1] = 1; // Release

        SW = 8'h55; // Next data = 0x55
        KEY[1] = 0;
        #20;
        KEY[1] = 1;

        // Read data
        #50;
        KEY[2] = 0; // Press read_enable
        #20;
        KEY[2] = 1; // Release

        #500;

        $stop; // End simulation
    end

endmodule
