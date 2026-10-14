module alu_test;
	logic [7:0] a;
	logic [7:0] b;
	logic [7:0] out;
	opcode_t opcode;
	logic zero;
	logic clk = 1'b1;
	
	// DUT instance 
	alu a0 (.out(out),.clk(clk),.a(a), .b(b),.opcode(opcode),.zero(zero));
	
	//clk generate 
	always #5 clk = ~clk;
	
	//initialzie self checking directed tests
	initial begin
		// 1. ADD (000): a + b
		@(negedge clk)
		opcode = 3'b000; a=8'd10; b=8'd10; // 10 + 10 = 20, zero = 0
		@(negedge clk)
		expect_test(8'd20, 1'b0); 

		// 2. SUB (001): a - b 
		// (Testing zero flag by making the result 0)
		@(negedge clk)
		opcode = 3'b001; a=8'd25; b=8'd25; // 25 - 25 = 0, zero = 1
		@(negedge clk)
		expect_test(8'd0, 1'b1); 

		// 3. MUL (010): a * b
		@(negedge clk)
		opcode = 3'b010; a=8'd5; b=8'd4; // 5 * 4 = 20, zero = 0
		@(negedge clk)
		expect_test(8'd20, 1'b0); 

		// 4. OR (011): a | b
		@(negedge clk)
		opcode = 3'b011; a=8'b10100000; b=8'b00001111; 
		@(negedge clk)
		expect_test(8'b10101111, 1'b0); 

		// 5. AND (100): a & b
		@(negedge clk)
		opcode = 3'b100; a=8'b11110000; b=8'b10101010; 
		@(negedge clk)
		expect_test(8'b10100000, 1'b0); 

		// 6. XOR (101): a ^ b
		@(negedge clk)
		opcode = 3'b101; a=8'b11111111; b=8'b10101010; 
		@(negedge clk)
		expect_test(8'b01010101, 1'b0); 

		// 7. SLL (110): a << b (Shift Left)
		@(negedge clk)
		opcode = 3'b110; a=8'b00000011; b=8'd2; // Shift 3 left by 2 = 12
		@(negedge clk)
		expect_test(8'b00001100, 1'b0); 

		// 8. SRL (111): a >> b (Shift Right)
		@(negedge clk)
		opcode = 3'b111; a=8'b11000000; b=8'd3; // Shift 192 right by 3 = 24
		@(negedge clk)
		expect_test(8'b00011000, 1'b0); 
		
		$display("TEST passseD");
		$finish;
	end
	
	// expected results task definition
	task expect_test(input [7:0] expected,input bit expected_zero);
		if (out !== expected || zero !== expected_zero) begin
			$display("out:%d is not equal to expeected:%d",out,expected);
			$display("zero is not correct");
			$display("TEST FAILED");
			$finish;
		end
	endtask
endmodule
