`timescale 1ns / 1ps

module memory_interface (
    input wire clk,
    input wire write_enable,
    input wire [31:0] addr,
    input wire [31:0] write_data,
    output wire [31:0] read_data
);

    wire [6:0] word_addr = addr[8:2];  // 128 hàng = 7 bit

    wire [15:0] data_low, data_high;

    ram_16x128 ram_low (
        .clock(clk),
        .address(word_addr),
        .data(write_data[15:0]),
        .wren(write_enable),
        .q(data_low)
    );

    ram_16x128 ram_high (
        .clock(clk),
        .address(word_addr),
        .data(write_data[31:16]),
        .wren(write_enable),
        .q(data_high)
    );

    reg [31:0] read_data_reg;
    assign read_data = read_data_reg;

    always @(posedge clk) begin
        read_data_reg <= {data_high, data_low};

        if (write_enable) begin
            $display("[WRITE] addr=%02h, high=%h, low=%h",
                     word_addr, write_data[31:16], write_data[15:0]);
        end

        $display("[READ]  addr=%02h, high=%h, low=%h => %h",
                 word_addr, data_high, data_low, {data_high, data_low});
    end

endmodule
