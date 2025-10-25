// multiplication accelerator peripheral for the 6502 CPU
// takes in 2 eight bit numbers and multiplies them

module multaccel (inout wire [7:0]D, 
                input logic RWB, 
                input logic CE, 
                input logic A0, 
                input logic clk)

    logic [7:0]A;
    logic [7:0]B;
    logic [15:0]out;
    logic [7:0]Dout;

    // input when CE high and RWB 1 (reading)
    always_ff @(posedge clk) begin
        if (CE && RWB && A0) begin
            // input to B register if A0 is 1
            B <= D; // FYI this symbol is non-blocking assignment
        end else if (CE && RWB && !A0) begin
            // input to A register if A0 is 0
            A <= D;
        end
    end

    always_comb begin
    // multiply A and B registers
        out = A * B;
        Dout = A0 ? B : A; // if A0 high, then B, else A (basically muxing using A0)
    end

    // output at the end if CE high and RWB low
    assign D = (CE && !RWB) ? Dout : 8'hZZ;
    
endmodule: