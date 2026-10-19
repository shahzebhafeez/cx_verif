module top;
	logic clk;
	logic write;
	logic read;
	logic [4:0] address;
	logic [7:0] data_in;
	logic [7:0] data_out;

	initial clk = 0;
	always #5 clk = ~clk;
	//DUT
	memory i0 (.clk(clk),.read(read),.write(write),.addr(address),.data_in(data_in),.data_out(data_out));

	// data0 to addr0 ... data32 to addr32
	mem_data_map j0 (.clk(clk),.read(read),.write(write),.addr(address),.data_in(data_in),.data_out(data_out));
	
	// testbench
	// mem_test r0 (.clk(clk),.read(read),.write(write),.address(address),.data_in(data_in),.data_out(data_out));

endmodule
