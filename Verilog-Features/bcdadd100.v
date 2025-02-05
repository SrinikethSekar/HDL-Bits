module bcd_100adder (
    input [399:0] a,  
    input [399:0] b,  
    input         cin,  
    output        cout,  
    output [399:0] sum  
);

    wire [99:0] carry;  

    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin : bcd_adders
            bcd_fadd adder (
                .a(a[4*i +: 4]),  
                .b(b[4*i +: 4]),  
                .cin(i == 0 ? cin : carry[i-1]),  
                .sum(sum[4*i +: 4]),  
                .cout(carry[i])  
            );
        end
    endgenerate

    assign cout = carry[99];  

endmodule
