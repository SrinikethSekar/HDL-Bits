module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

  parameter OFF=0, ON=1; 
    reg [1:0] state, next_state;

    always @(*) begin
        case(state)
            OFF:next_state=(j==1'b0)?OFF:ON;
            ON:next_state=(k==1'b0)?ON:OFF;
        endcase
    end

    always @(posedge clk) begin
        // State flip-flops with asynchronous reset
        if(reset)
            state<=OFF;
        else
            state<=next_state;
    end

    
    assign out = (state == ON);

endmodule

