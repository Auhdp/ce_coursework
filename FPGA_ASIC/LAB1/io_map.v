module io_map (
    input  [7:0] SW,      
    output [7:0] LEDR     
);
    assign LEDR = SW;     
endmodule
