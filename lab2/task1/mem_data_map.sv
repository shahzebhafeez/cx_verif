
module mem_data_map(mem_interf.tb mif);

    integer i;
    logic [7:0] my_data;
    logic [7:0] received_data;

    // Store expected random data
    logic [7:0] expected_mem [0:31];

    initial begin
        mif.write   = 0;
        mif.read    = 0;
        mif.data_in = 0;
        mif.addr    = 0;

        // Write random data to all addresses
        for (i = 0; i < 32; i = i + 1) begin
            my_data = $urandom_range(0, 255);
            expected_mem[i] = my_data;

            mif.write_mem(i, my_data);
        end

        // Read and verify all addresses
        for (int j = 0; j < 32; j = j + 1) begin
            mif.read_mem(j, received_data);

            if (received_data !== expected_mem[j]) begin
                $error("FAIL: Address=%0d, Expected=%h, Actual=%h",
                       j, expected_mem[j], received_data);
            end
            else begin
                $display("PASS: Address=%0d, Data=%h",
                         j, received_data);
            end
        end

        // Disable read
        @(negedge mif.clk);
        mif.read = 0;

        $finish;
    end

endmodule

