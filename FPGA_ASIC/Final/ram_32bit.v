module  (
    input wire clk,
    input wire we,
    input wire [6:0] addr, // 128 dòng
    input wire [31:0] data_in,
    output wire [31:0] data_out
);

    wire [15:0] lower_out, upper_out;

    // RAM thấp (bit 15:0)
    ram_16x128 ram_low (
        .clock(clk),
        .wren(we),
        .address(addr),
        .data(data_in[15:0]),
        .q(lower_out)
    );

    // RAM cao (bit 31:16)
    ram_16x128 ram_high (
        .clock(clk),
        .wren(we),
        .address(addr),
        .data(data_in[31:16]),
        .q(upper_out)
    );

    assign data_out = {upper_out, lower_out};
endmodule
