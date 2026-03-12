module clock_divider #(parameter MAX_COUNT = 50) (
    input clk,
    input reset_n,
    output reg enable_1hz,
    output reg [31:0] counter  
);

    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            counter <= 0;
            enable_1hz <= 0;
        end else if (counter < MAX_COUNT - 1) begin
            counter <= counter + 1;
            enable_1hz <= 0;
        end else begin
            counter <= 0;
            enable_1hz <= 1;
        end
    end
endmodule
