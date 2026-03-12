module registerN #(parameter N = 8)(
    input clk,
    input rst,
    input load,
    input [N-1:0] d,
    output reg [N-1:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 0;
        else if (load)
            q <= d;
    end
endmodule
