
module memory (
    input  logic       clk,
    input  logic       read,
    input  logic       write,
    input  logic [4:0] addr,
    input  logic [7:0] data_in,
    output logic [7:0] data_out
);

    // 32 locations, each 8 bits wide
    logic [7:0] mem [0:31];

    // Synchronous memory operation
    always_ff @(posedge clk) begin
        if (write && !read) begin
            mem[addr] <= data_in; // non blocking on positive edge
        end
        else if (read && !write) begin
            data_out <= mem[addr];
        end
    end

endmodule

