module datapath_top(
    input clk,
    input rst,
    input [9:0] SW,
    input [2:1] KEY,
    output [6:0] HEX0, HEX1, HEX2, HEX3,
    output [7:0] LEDR
);

    wire [7:0] regA_out, regB_out;
    wire [7:0] mux_out, alu_out;

    // Register A load from SW[7:0] when KEY[1] pressed
    registerN #(8) regA (
        .clk(clk),
        .rst(rst),
        .load(KEY[1]),
        .d(SW[7:0]),
        .q(regA_out)
    );

    // Input to ALU: from MUX
    mux2to1_N #(8) mux (
        .in0(SW[7:0]),
        .in1(regB_out),
        .sel(SW[8]),
        .out(mux_out)
    );

    // ALU
    simpleALU #(8) alu (
        .a(mux_out),
        .b(regA_out),
        .op(SW[9]),
        .result(alu_out)
    );

    // Register B gets data from ALU output when KEY[2] pressed
    registerN #(8) regB (
        .clk(clk),
        .rst(rst),
        .load(KEY[2]),
        .d(alu_out),
        .q(regB_out)
    );

    assign LEDR = alu_out;

    // Hiển thị 8-bit regA, regB lên HEX
    hex_decoder h0 (.in(regA_out[3:0]), .out(HEX0));
    hex_decoder h1 (.in(regA_out[7:4]), .out(HEX1));
    hex_decoder h2 (.in(regB_out[3:0]), .out(HEX2));
    hex_decoder h3 (.in(regB_out[7:4]), .out(HEX3));

endmodule
