module register_test;
	logic clk = 1'b0;
	logic [7:0] data;
	logic [7:0] out;
	logic rst_=1'b1;
	logic enable;
	
	// DUT instantion 
	register r0 (.clk(clk),.data(data),.out(out),.rst_(rst_),.enable(enable));
	
	//internal clock 
	always #5 clk = ~clk;
	
	// tests
	initial begin 
		      @(negedge clk)
			      { rst_, enable, data } = 10'b1_X_XXXXXXXX; @(negedge clk)
			expect_test ( 8'hXX );
			      { rst_, enable, data } = 10'b0_X_XXXXXXXX; @(negedge clk)
			expect_test ( 8'h00 );
			      { rst_, enable, data } = 10'b1_0_XXXXXXXX; @(negedge clk)
			expect_test ( 8'h00 );
			      { rst_, enable, data } = 10'b1_1_10101010; @(negedge clk)
			expect_test ( 8'hAA );
			      { rst_, enable, data } = 10'b1_0_01010101; @(negedge clk)
			expect_test ( 8'hAA );
			      { rst_, enable, data } = 10'b0_X_XXXXXXXX; @(negedge clk)
			expect_test ( 8'h00 );
			      { rst_, enable, data } = 10'b1_0_XXXXXXXX; @(negedge clk)
			expect_test ( 8'h00 );
			      { rst_, enable, data } = 10'b1_1_01010101; @(negedge clk)
			expect_test ( 8'h55 );
			      { rst_, enable, data } = 10'b1_0_10101010; @(negedge clk)
			expect_test ( 8'h55 );
			$display("TEST HAVE PASSEd");
			$finish;
	end
	
	//display data
	initial
	  begin
	    $timeformat ( -9, 1, " ns", 9 );
	    $monitor ( "time=%t enable=%b rst_=%b data=%h out=%h",
		       $time,  enable,   rst_,   data,   out );
	    #(5 * 99)
	    $display ( "REGISTER TEST TIMEOUT" );
	    $finish;
	end

	task expect_test(input [7:0] expects);
		if (out !== expects) begin
			$display ( "out=%b, should be %b", out, expects );
		        $display ( "REGISTER TEST FAILED" );
		        $finish;
		end
	endtask
	
	
endmodule
