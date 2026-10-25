interface counter_interf(input logic clk);

    logic [31:0] count_value;
    bit carry;
    bit borrow;

    modport tb (
        input  clk,
        output count_value,
	output carry,
	output borrow
    );

endinterface
