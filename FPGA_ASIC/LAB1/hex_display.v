module hex_display (
    input  [7:0] SW,
    output [6:0] HEX0,     // Displays SW[3:0]
    output [6:0] HEX1      // Displays SW[7:4]
);
    wire [3:0] low_nibble = SW[3:0];
    wire [3:0] high_nibble = SW[7:4];

    hex_decoder hd0 (.hex_digit(low_nibble),  .seg(HEX0));
    hex_decoder hd1 (.hex_digit(high_nibble), .seg(HEX1));
endmodule
