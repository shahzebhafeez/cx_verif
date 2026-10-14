module register (
    input  logic       clk,
    input  logic       rst_,   // Active-low reset
    input  logic       enable,
    input  logic [7:0] data,
    output logic [7:0] out
);

    // Hardware modeling of a flip-flop register
    // Triggered on the rising edge of the clock, or falling edge of reset
    always_ff @(posedge clk or negedge rst_) begin
        
        if (!rst_) begin
            // 1. If reset is 0 (active-low), clear the output to 0
            out <= 8'h00;
            
        end else if (enable) begin
            // 2. If reset is 1 and enable is 1, load the new data
            out <= data;
            
        end
        // 3. If reset is 1 and enable is 0, do nothing (it holds its old value)
    end

endmodule
