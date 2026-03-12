module simpleALU #(parameter N = 8)(
    input [N-1:0] a,
    input [N-1:0] b,
    input op,  // 0 = add, 1 = subtract
    output [N-1:0] result
);
    assign result = op ? (a - b) : (a + b);
endmodule
