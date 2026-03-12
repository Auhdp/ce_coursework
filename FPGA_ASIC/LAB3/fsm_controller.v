module fsm_controller (
    input wire clk,
    input wire reset_n,
    input wire load_enable,
    input wire read_enable,
    input wire [7:0] write_data,
    input wire [7:0] ram_data_out,
    output reg [4:0] ram_address,
    output reg ram_wren,
    output reg [7:0] ram_data_in,
    output reg [7:0] display_data,
    output reg [4:0] display_address
);

    // Define states using parameter
    parameter IDLE = 3'b000,
              LOAD_ADDR = 3'b001,
              WRITE_CYCLE = 3'b010,
              READ_ADDR = 3'b011,
              READ_WAIT = 3'b100,
              READ_CYCLE = 3'b101;

    reg [2:0] current_state, next_state;
    reg [4:0] load_addr;
    reg [4:0] read_addr;

    // State transitions
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE:
                if (load_enable)
                    next_state = LOAD_ADDR;
                else if (read_enable)
                    next_state = READ_ADDR;
                else
                    next_state = IDLE;

            LOAD_ADDR: 
                next_state = WRITE_CYCLE;

            WRITE_CYCLE: 
                if (load_enable)
                    next_state = LOAD_ADDR;
                else
                    next_state = IDLE;

            READ_ADDR: 
                next_state = READ_WAIT;

            READ_WAIT: 
                next_state = READ_CYCLE;

            READ_CYCLE:
                if (read_enable)
                    next_state = READ_ADDR;
                else
                    next_state = IDLE;

            default: 
                next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            load_addr <= 5'd0;
            read_addr <= 5'd0;
            ram_address <= 5'd0;
            ram_wren <= 1'b0;
            ram_data_in <= 8'd0;
            display_data <= 8'd0;
            display_address <= 5'd0;
        end else begin
            case (current_state)
                IDLE: begin
                    ram_wren <= 1'b0;
                end

                LOAD_ADDR: begin
                    ram_address <= load_addr;
                    ram_data_in <= write_data;
                    ram_wren <= 1'b1;
                end

                WRITE_CYCLE: begin
                    ram_wren <= 1'b0;
                    load_addr <= load_addr + 1;
                end

                READ_ADDR: begin
                    ram_address <= read_addr;
                    ram_wren <= 1'b0;
                end

                READ_WAIT: begin
                    // No action, just wait for data valid
                end

                READ_CYCLE: begin
                    display_data <= ram_data_out;
                    display_address <= read_addr;
                    read_addr <= read_addr + 1;
                end
            endcase
        end
    end

endmodule
vcom ram.v