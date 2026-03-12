module TopLevelCPU (
    input wire clk,
    input wire reset_n,
    input wire [2:0] reg_select,
    output wire [15:0] PC_out,
    output wire [15:0] reg_out,
    output wire zero_flag,
    output wire sign_flag,
    output wire [2:0] CU_state,
    output wire [15:0] IR_out
);

    wire reset = ~reset_n;
// ubinbs tesbtecn ddaauf voo 
    // Instruction and decoding
    wire [31:0] pc, next_pc;
    wire [31:0] instruction;
    wire [5:0] opcode = instruction[31:26];
		wire [5:0] funct  = instruction[5:0];
    wire [2:0] rs = instruction[25:23];
    wire [2:0] rt = instruction[20:18];
    wire [2:0] rd = instruction[15:13];
    wire [15:0] imm = instruction[15:0];

    // Register interface
    wire [31:0] reg_data1, reg_data2, reg_write_data;
    wire [31:0] alu_result, fp_result, alu_in_a, alu_in_b;
    wire [3:0] alu_op;
    wire zero, sign;
    wire [31:0] imm_ext;

    // Control
    wire pc_write, ir_write, reg_write, mem_write, mem_read;
    wire [1:0] alu_src_a, alu_src_b;
    wire mem_to_reg, reg_dst;
    wire fp_en;
    wire [1:0] fp_op;
    wire [2:0] state;

    // Memory
    wire [31:0] mem_read_data;

    // FP flags
    wire fp_zero, fp_sign;

    // PC Module
    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .load(pc_write),
        .pc_out(pc)
    );

    // Instruction Register
    instruction_register ir_inst (
        .clk(clk),
        .load(ir_write),
        .instruction_in(mem_read_data),
        .instruction_out(instruction)
    );

    // Register File
    register_file rf_inst (
        .clk(clk),
        .reg_write(reg_write),
        .read_reg1(rs),
        .read_reg2(rt),
        .write_reg(reg_dst ? rd : rt),
        .write_data(reg_write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // Immediate Extend
    sign_extend se_inst (.in(imm), .out(imm_ext));

    // ALU Input Selection
    mux2 #(32) alu_srca_mux (.sel(alu_src_a[0]), .a(pc), .b(reg_data1), .y(alu_in_a));
    mux2 #(32) alu_srcb_mux (.sel(alu_src_b[0]), .a(reg_data2), .b(imm_ext), .y(alu_in_b));

    // Integer ALU
    alu alu_inst (
        .a(alu_in_a),
        .b(alu_in_b),
        .alu_op(alu_op),
        .result(alu_result),
        .zero_flag(zero),
        .sign_flag(sign)
    );

    // Floating Point ALU
    fp_alu fpalu_inst (
        .a(reg_data1),
        .b(reg_data2),
        .op(fp_op),
        .result(fp_result),
        .zero_flag(fp_zero),
        .sign_flag(fp_sign),
        .nan_flag()  // bỏ qua vì không cần dùng
    );

    // Select ALU/FP Result -> RegWriteData
    mux2 #(32) result_mux (
        .sel(mem_to_reg),
        .a(fp_en ? fp_result : alu_result),
        .b(mem_read_data),
        .y(reg_write_data)
    );

    // RAM Memory Interface
    memory_interface mem_inst (
        .clk(clk),
        .write_enable(mem_write),
        .addr(alu_result),
        .write_data(reg_data2),
        .read_data(mem_read_data)
    );

    // Control Unit FSM
    control_unit cu_inst (
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .funct(funct),
        .state(state),
        .pc_write(pc_write),
        .ir_write(ir_write),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .alu_src_a(alu_src_a),
        .alu_src_b(alu_src_b),
        .alu_op(alu_op),
        .mem_to_reg(mem_to_reg),
        .reg_dst(reg_dst),
        .fp_en(fp_en),
        .fp_op(fp_op)
    );
	 
	 
	 
	 // input 
	 
	 assign reg_out = (reg_select == 3'b000) ? reg_data1[15:0] :
                 (reg_select == 3'b001) ? reg_data2[15:0] :
                 (reg_select == 3'b010) ? reg_write_data[15:0] :
                 16'hDEAD;  // mặc định nếu sai mã

    // Outputs
    assign PC_out = pc[15:0];
    assign zero_flag = fp_en ? fp_zero : zero;
    assign sign_flag = fp_en ? fp_sign : sign;
    assign CU_state = state;
    assign IR_out = instruction[15:0];

endmodule
