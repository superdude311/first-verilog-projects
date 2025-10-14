// test of 18-100 3 bit adder in sv

module halfadder (output logic s, c, input logic, d[1:0])
    and (c, d[0], d[1]);
    xor (s, d[0], d[1]);
endmodule:

module fulladder (output logic s, c, input logic, d[1:0], cin)
    halfadder ha0 (sum, carry1, d[1:0]);
    halfadder ha1 (s, carry2, cin, sum);
    or (c, carry1, carry2);
endmodule:

module 3b-adder (output logic o[2:1], cout input logic a[2:0], b[2:0])
    fulladder fa0 (o[0], c1, a[0], b[0], 1'b0);
    fulladder fa1 (o[1], c2, a[1], b[1], c1);
    fulladder fa2 (o[2], cout, a[2], b[2], c2);
endmodule:
