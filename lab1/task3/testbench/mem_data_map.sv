
module mem_data_map(
    input  logic clk,
    output logic write,
    output logic read,
    output logic [4:0] addr,
    output logic [7:0] data_in,
    input  logic [7:0] data_out
);

    integer i;
    logic [7:0] my_data;

    // Store expected random data
    logic [7:0] expected_mem [0:31];

    initial begin
        write = 0;
        read = 0;
        data_in = 0;
        addr = 0;

        // Write random data to each address
        for(i = 0; i < 32; i = i + 1) begin
            my_data = $urandom_range(0,255);
            expected_mem[i] = my_data;
            stream_data(i, my_data);
        end

        // Stop writing
        @(negedge clk);
        write = 0;

        // Read back and verify
        mem_read();

        $finish;
    end

    // Task to stream data to DUT
    task stream_data(
        input logic [4:0] address_in,
        input logic [7:0] data
    );
        @(negedge clk);
        write = 1;
        read = 0;
        addr = address_in;
        data_in = data;
    endtask

    // Task to read and verify memory
    task mem_read();
        for(int j = 0; j < 32; j = j + 1) begin
            @(negedge clk);
            write = 0;
            read = 1;
            addr = j;

            @(posedge clk);
            #1;

            if(data_out !== expected_mem[j]) begin
                $error("FAIL: Address=%0d, Expected=%h, Actual=%h",
                       j, expected_mem[j], data_out);
            end
            else begin
                $display("PASS: Address=%0d, Data=%h",
                         j, data_out);
            end
        end

        @(negedge clk);
        read = 0;
    endtask

endmodule

