`timescale 1ns/1ps

module tb_bcd_counter();

    reg clk;
    reg reset_n;
    reg enable;
    wire [3:0] digit0, digit1, digit2;

    bcd_counter uut (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .digit0(digit0),
        .digit1(digit1),
        .digit2(digit2)
    );

    always #10 clk = ~clk;

    initial begin
        $display("---- Simulation bcd_counter ----");
        clk = 0;
        reset_n = 0;
        enable = 0;

     
        #50 reset_n = 1;
        enable = 1;

      
        $monitor("Time=%0t ns | digit2=%0d digit1=%0d digit0=%0d", $time, digit2, digit1, digit0);

       
        #1000;

        $stop;
    end
endmodule
