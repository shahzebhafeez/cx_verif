module alu_test;
	logic [7:0] a;
	logic [7:0] b;
	logic [7:0] out;
	opcode_t opcode;
	logic zero;
	logic clk = 1'b1;
	logic [7:0] result;
	
	// DUT instance 
	alu a0 (.out(out),.clk(clk),.a(a), .b(b),.opcode(opcode),.zero(zero));
	
	//clk generate 
	always #5 clk = ~clk;
	
		// initialize self checking directed tests
	initial begin
		// 1. ADD (000): a + b
		@(negedge clk)
		opcode = 3'b000; 
		a = $urandom; b = $urandom; 
		result = a + b;
		@(negedge clk)
		expect_test(result, (result == 8'h00)); 

		// 2. SUB (001): a - b 
		@(negedge clk)
		opcode = 3'b001; 
		a = $urandom; b = $urandom; 
		result = a - b;
		@(negedge clk)
		expect_test(result, (result == 8'h00)); 

		// 3. MUL (010): a * b
		@(negedge clk)
		opcode = 3'b010; 
		a = $urandom; b = $urandom; 
		result = a * b;
		@(negedge clk)
		expect_test(result, (result == 8'h00)); 

		// 4. OR (011): a | b
		@(negedge clk)
		opcode = 3'b011; 
		a = $urandom; b = $urandom; 
		result = a | b; 
		@(negedge clk)
		expect_test(result, (result == 8'h00)); 

		// 5. AND (100): a & b
		@(negedge clk)
		opcode = 3'b100; 
		a = $urandom; b = $urandom; 
		result = a & b; 
		@(negedge clk)
		expect_test(result, (result == 8'h00)); 

		// 6. XOR (101): a ^ b
		@(negedge clk)
		opcode = 3'b101; 
		a = $urandom; b = $urandom; 
		result = a ^ b; 
		@(negedge clk)
		expect_test(result, (result == 8'h00)); 

		// 7. SLL (110): a << b (Shift Left)
		// Limit shift amount to 0-7 so the result isn't always 0
		@(negedge clk)
		opcode = 3'b110; 
		a = $urandom; b = $urandom_range(0, 7); 
		result = a << b;
		@(negedge clk)
		expect_test(result, (result == 8'h00)); 

		// 8. SRL (111): a >> b (Shift Right)
		// Limit shift amount to 0-7 so the result isn't always 0
		@(negedge clk)
		opcode = 3'b111; 
		a = $urandom; b = $urandom_range(0, 7); 
		result = a >> b;
		@(negedge clk)
		expect_test(result, (result == 8'h00)); 
		
		$display("ALL RANDOMIZED TESTS PASSED!");
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
