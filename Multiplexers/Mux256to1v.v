module top_module( 
    input [1023:0] in,
    input [7:0] sel,
  output [3:0] out ); 
  assign out = in [sel *4 +: 4]; //The syntax in[start +: width] is called "indexed part-select", which extracts a slice of bits starting at start with a width of width.
endmodule
