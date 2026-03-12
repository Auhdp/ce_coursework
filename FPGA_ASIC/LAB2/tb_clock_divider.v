`timescale 1ns/1ps

module tb_clock_divider();

    reg clk;
    reg reset_n;
    wire enable_1hz;
    wire [31:0] counter; 

    localparam MAX_COUNT = 50;

    clock_divider #(MAX_COUNT) uut (
        .clk(clk),
        .reset_n(reset_n),
        .enable_1hz(enable_1hz),
        .counter(counter)  
    );

    always #10 clk = ~clk;

    initial begin
        $display("---- Simulation for MAX_COUNT = 50 ----");
        clk = 0;
        reset_n = 0;

       
        $monitor("Time = %0t ns, Counter = %d, enable_1hz = %b", $time, counter, enable_1hz);

        #50 reset_n = 1;
        #1200;  
        $stop;
    end

endmodule
