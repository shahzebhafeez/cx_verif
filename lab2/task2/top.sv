
module top;

    logic clk = 0;

    always #5 clk = ~clk;

    // Interface instance
    mem_interf mif(clk);

    // DUT
    mem i0 (
        .mif(mif)
    );

    // Testbench
    mem_data_map j0 (
        .mif(mif)
    );

endmodule

