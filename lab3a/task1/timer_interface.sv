interface counter_interf(input logic clk);

    logic [4:0] hours;
    logic [5:0] minutes;
    logic [5:0] seconds;

    logic carry;
    logic borrow;

    modport tb (
        input  clk,
        output hours,
        output minutes,
        output seconds,
        output carry,
        output borrow
    );

endinterface
