module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter [1:0] a=0, b=1, c=2, d=3;

    always_comb begin
        case(state)
            a:next_state=in?b:a;
            b:next_state=in?b:c;
            c:next_state=in?d:a;
            d:next_state=in?b:c;
        endcase
    end

    
    assign out = (state == d);

endmodule


