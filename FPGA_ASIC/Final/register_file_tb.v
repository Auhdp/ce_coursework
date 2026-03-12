`timescale 1ns / 1ps
module register_file_tb;

    reg clk;
    reg reg_write;
    reg [2:0] read_reg1, read_reg2, write_reg;
    reg [31:0] write_data;
    wire [31:0] read_data1, read_data2;

    register_file dut (
        .clk(clk),
        .reg_write(reg_write),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("===== REGISTER FILE TEST BEGIN =====");

        // Ghi A5A5A5A5 vào R1
        reg_write = 1; write_reg = 3'd1; write_data = 32'hA5A5A5A5;
        #10; reg_write = 0; // rising edge
        #10; // wait one more cycle

        read_reg1 = 3'd1; read_reg2 = 3'd2;
        #10;
        $display("Read_data1 = %h (Expect A5A5A5A5)", read_data1);
        $display("Read_data2 = %h (Expect 00000000)", read_data2);

        // Ghi DEADBEEF vào R2
        reg_write = 1; write_reg = 3'd2; write_data = 32'hDEADBEEF;
        #10; reg_write = 0;
        #10;

        read_reg1 = 3'd1; read_reg2 = 3'd2;
        #10;
        $display("Read_data1 = %h (Expect A5A5A5A5)", read_data1);
        $display("Read_data2 = %h (Expect DEADBEEF)", read_data2);

        $display("===== REGISTER FILE TEST END =====");
        $stop;
    end

endmodule
