module flop_tb;

// Khai báo các biến
reg clk;
reg d;
wire q;

// Khởi tạo module flop
flop uut (
    .clk(clk),
    .d(d),
    .q(q)
);

// Tạo xung nhịp với chu kỳ 10 đơn vị thời gian
always #5 clk = ~clk;

// Bắt đầu thử nghiệm
initial begin
    // Khởi tạo tín hiệu
    clk = 0;
    d = 0;
    
    // Gán giá trị cho d và quan sát q
    #10; d = 1; // Đặt d = 1 tại thời điểm 10 đơn vị thời gian
    #10; d = 0; // Đặt d = 0 tại thời điểm 20 đơn vị thời gian
    #10; d = 1; // Đặt d = 1 tại thời điểm 30 đơn vị thời gian
    #10; d = 0; // Đặt d = 0 tại thời điểm 40 đơn vị thời gian
    #10; d = 1; // Đặt d = 1 tại thời điểm 50 đơn vị thời gian

    // Kết thúc thử nghiệm
    #10 $finish;
end

// In giá trị của d và q tại mỗi cạnh dương của xung nhịp
initial begin
    $monitor("At time %t, d = %b, q = %b", $time, d, q);
end

endmodule
