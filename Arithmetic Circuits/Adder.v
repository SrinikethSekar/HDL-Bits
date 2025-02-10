module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire [2:0] car;
    fadd inst1(x[0] , y[0], 1'b0, sum[0],car[0]);
    fadd inst2(x[1] , y[1], car[0], sum[1],car[1]);
    fadd inst3(x[2] , y[2], car[1], sum[2],car[2]);
    fadd inst4(x[3] , y[3], car[2], sum[3],sum[4]);
endmodule
module fadd(input a,b,c_in, output sum, carry);
    assign {carry,sum} = a+b+c_in;
endmodule
