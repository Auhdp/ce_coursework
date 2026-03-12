`timescale 1ns / 1ps

module tb_hex_decoder;

    // Khai báo tín hiệu test
    reg  [3:0] hex;
    wire [6:0] seg;

    // Gọi module cần test
    hex_decoder uut (
        .hex(hex),
        .seg(seg)
    );

    integer i;

    initial begin
        $display("Thời gian | HEX | SEG (ABCDEFG)");
        $monitor("%4dns     | %h   | %b", $time, hex, seg);
        
        // Test tất cả các giá trị từ 0 đến F
        for (i = 0; i < 16; i = i + 1) begin
            hex = i[3:0];  // đảm bảo 4-bit
            #10;           // chờ 10ns
        end

        $finish;
    end

endmodule
