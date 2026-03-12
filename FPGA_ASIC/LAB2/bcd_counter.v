module bcd_counter(
    input clk,
    input reset_n,
    input enable,
    output reg [3:0] digit0,
    output reg [3:0] digit1,
    output reg [3:0] digit2
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            digit0 <= 4'd0;
            digit1 <= 4'd0;
            digit2 <= 4'd0;
        end else if (enable) begin
            // digit0
            if (digit0 == 4'd9) begin
                digit0 <= 4'd0;
                // digit1
                if (digit1 == 4'd9) begin
                    digit1 <= 4'd0;
                    // digit2
                    if (digit2 == 4'd9)
                        digit2 <= 4'd0;
                    else
                        digit2 <= digit2 + 1;
                end else begin
                    digit1 <= digit1 + 1;
                end
            end else begin
                digit0 <= digit0 + 1;
            end
        end
    end
endmodule
