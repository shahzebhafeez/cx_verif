
interface mem_interf(input logic clk);

    logic       write;
    logic       read;
    logic [4:0] addr;
    logic [7:0] data_in;
    logic [7:0] data_out;

    // DUT modport
    modport DUT (
        input  clk, write, read, addr, data_in,
        output data_out
    );

    // Testbench modport
    modport tb (
        input  clk, data_out,
        output write, read, addr, data_in,
        import task write_mem,
        import task read_mem
    );

    // Write task
    task automatic write_mem(
        input logic [4:0] address_in,
        input logic [7:0] data
    );
        @(negedge clk);

        write   = 1;
        read    = 0;
        addr    = address_in;
        data_in = data;
    endtask

    // Read task
    task automatic read_mem(
        input  logic [4:0] address_in,
        output logic [7:0] read_data
    );
        @(negedge clk);

        write = 0;
        read  = 1;
        addr  = address_in;

        @(posedge clk);
        #1;

        read_data = data_out;
    endtask

endinterface

