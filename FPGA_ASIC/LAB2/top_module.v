module top_module(
    input CLOCK_50,
    input [0:0] KEY, // KEY[0] là reset_n
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2
);

    wire enable_1hz;
    wire [3:0] digit0, digit1, digit2;

    // clock divider
    clock_divider clkdiv (
        .clk(CLOCK_50),
        .reset_n(KEY[0]),
        .enable_1hz(enable_1hz)
    );

    // bcd counter
    bcd_counter counter (
        .clk(CLOCK_50),
        .reset_n(KEY[0]),
        .enable(enable_1hz),
        .digit0(digit0),
        .digit1(digit1),
        .digit2(digit2)
    );

    // hex decoders
    hex_decoder h0 (.hex_digit(digit0), .seg(HEX0));
    hex_decoder h1 (.hex_digit(digit1), .seg(HEX1));
    hex_decoder h2 (.hex_digit(digit2), .seg(HEX2));

endmodule
