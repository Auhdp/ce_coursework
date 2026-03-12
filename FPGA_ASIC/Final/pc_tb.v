`timescale 1ns / 1ps

module pc_tb;
    reg clk, reset, load;
    reg [31:0] next_pc;
    wire [31:0] pc_out;

    pc dut (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .load(load),
        .pc_out(pc_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;  // 10ns period

    task print_pc;
        begin
            $display("Time: %0t ns | PC_out = %h", $time, pc_out);
        end
    endtask

    initial begin
        $display("===== PC MODULE TEST BEGIN =====");

        // Reset
        reset = 1; load = 0; next_pc = 0;
        #10; print_pc(); // expect 00000000
        reset = 0;

        // Load value
        load = 1; next_pc = 32'hABCD1234;
        #10; print_pc(); // expect ABCD1234
        load = 0;

        // Auto increment 3 cycles
        #10; print_pc(); // ABCD1238
        #10; print_pc(); // ABCD123C
        #10; print_pc(); // ABCD1240

        // Load another value
        load = 1; next_pc = 32'h11112222;
        #10; print_pc(); // expect 11112222
        load = 0;

        // Auto increment 2 cycles
        #10; print_pc(); // 11112226
        #10; print_pc(); // 1111222A

        // Final reset
        reset = 1;
        #10; print_pc(); // expect 00000000
        reset = 0;

        $display("===== PC MODULE TEST END =====");
        $stop;
    end
endmodule
