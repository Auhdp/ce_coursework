module top_module (
    input wire CLOCK_50,
    input wire [2:0] KEY,   // KEY[0] = reset_n, KEY[1] = load_enable, KEY[2] = read_enable
    input wire [7:0] SW,    // SW[7:0] = data input
    output wire [6:0] HEX0,
    output wire [6:0] HEX1,
    output wire [6:0] HEX4,
    output wire [6:0] HEX5
);

    // Internal wires
    wire [4:0] ram_address;
    wire ram_wren;
    wire [7:0] ram_data_in;
    wire [7:0] ram_data_out;
    wire [7:0] display_data;
    wire [4:0] display_address;

    // Instantiate RAM
    ram u_ram (
        .clock (CLOCK_50),
        .address (ram_address),
        .data (ram_data_in),
        .wren (ram_wren),
        .q (ram_data_out)
    );

    // Instantiate FSM Controller
    fsm_controller u_fsm (
        .clk (CLOCK_50),
        .reset_n (KEY[0]),
        .load_enable (KEY[1]),
        .read_enable (KEY[2]),
        .write_data (SW),
        .ram_data_out (ram_data_out),
        .ram_address (ram_address),
        .ram_wren (ram_wren),
        .ram_data_in (ram_data_in),
        .display_data (display_data),
        .display_address (display_address)
    );

    // Instantiate HEX decoders
    hex_decoder u_hex0 (
        .hex_value (display_data[3:0]),
        .segments (HEX0)
    );

    hex_decoder u_hex1 (
        .hex_value (display_data[7:4]),
        .segments (HEX1)
    );

    hex_decoder u_hex4 (
        .hex_value (display_address[3:0]),
        .segments (HEX4)
    );

    hex_decoder u_hex5 (
        .hex_value ({3'b000, display_address[4]}),
        .segments (HEX5)
    );

endmodule
