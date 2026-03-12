module tb;

    reg clk = 0, rst = 0;
    reg [9:0] SW;
    reg [2:1] KEY;
    wire [6:0] HEX0, HEX1, HEX2, HEX3;
    wire [7:0] LEDR;

    datapath_top uut (
        .clk(clk), .rst(rst),
        .SW(SW), .KEY(KEY),
        .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3),
        .LEDR(LEDR)
    );

    always #5 clk = ~clk; // clock 10ns

    initial begin
        // Reset system
        rst = 1; #10;
        rst = 0;

        // Load RegA = 8'h12
        SW[7:0] = 8'h12; SW[8] = 0; SW[9] = 0; // MUX select SW, ALU add
        KEY[1] = 1; #10; KEY[1] = 0; #10;

        // Change SW to 8'h34, still MUX=0, ALU=add
        SW[7:0] = 8'h34;

        // ALU should compute 0x12 + 0x34 = 0x46, load into RegB
        KEY[2] = 1; #10; KEY[2] = 0; #10;

        // Switch to MUX=1, input is RegB now, ALU=SUB
        SW[8] = 1; SW[9] = 1;

        // ALU does RegB - RegA = 0x46 - 0x12 = 0x34
        KEY[2] = 1; #10; KEY[2] = 0; #10;

        $stop;
    end

endmodule
