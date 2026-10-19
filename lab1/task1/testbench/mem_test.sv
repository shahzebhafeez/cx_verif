
module mem_test(
    input  logic       clk,
    output logic       write,
    output logic       read,
    output logic [4:0] address,
    output logic [7:0] data_in,
    input  logic [7:0] data_out
);

    integer i;
    integer j;

    // TEST 1
    // Clear all memory addresses to 0
    // Then read and verify

    initial begin
        write = 0;
        read = 0;
        address = 0;
        data_in = 0;

        // Write 0 to each address
        for(i = 0; i < 32; i = i + 1) begin
            @(negedge clk);
            write = 1;
            read = 0;
            address = i;
            data_in = 0;
        end

        @(negedge clk);
        write = 0;

        mem_check();
        $finish;
    end

    // Task to check memory contents
    task mem_check();
        for(j = 0; j < 32; j = j + 1) begin
            @(negedge clk);
            write = 0;
            read = 1;
            address = j;

            @(posedge clk);
            #1;

            if(data_out !== 8'h00) begin
                $display("Data not cleared at address: %d, data is: %d",
                         j, data_out);
            end
            else begin
                $display("Address %d cleared successfully", j);
            end
        end

        @(negedge clk);
        read = 0;
    endtask

endmodule

