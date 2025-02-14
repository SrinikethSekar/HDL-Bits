
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    reg [7:0] cnt;
    
    parameter [2:0] LEFT=3'b000, 
                    RIGHT=3'b001, 
                    FALL_L=3'b010, 
                    FALL_R=3'b011,
                    DIG_L=3'b100, 
                    DIG_R=3'b101, 
                    SPA=3'b110;
    
    reg [2:0] state, next_state;

    always @(*) begin
        case(state)
            LEFT: begin
                if (!ground) 
                    next_state = FALL_L;
                else if (ground && dig) 
                    next_state = DIG_L;
                else if (bump_left) 
                    next_state = RIGHT;
                else 
                    next_state = LEFT;
            end

            RIGHT: begin
                if (!ground) 
                    next_state = FALL_R;
                else if (ground && dig) 
                    next_state = DIG_R;
                else if (bump_right) 
                    next_state = LEFT;
                else 
                    next_state = RIGHT;
            end
            
            FALL_L: begin
                if (!ground) 
                    next_state = FALL_L;
                else if (cnt > 8'd19) 
                    next_state = SPA;
                else 
                    next_state = LEFT;
            end
            
            FALL_R: begin
                if (!ground) 
                    next_state = FALL_R;
                else if (cnt > 8'd19) 
                    next_state = SPA;
                else 
                    next_state = RIGHT;
            end

            DIG_L: begin
                if (!ground) 
                    next_state = FALL_L;
                else 
                    next_state = DIG_L;
            end
            
            DIG_R: begin
                if (!ground) 
                    next_state = FALL_R;
                else 
                    next_state = DIG_R;
            end
            
            SPA: next_state = SPA; 
            
            default: next_state = LEFT;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            cnt <= 0;
        end 
        else begin
            if (state == FALL_L || state == FALL_R)
                cnt <= cnt + 1;
            else 
                cnt <= 0;
            
            state <= next_state;
        end
    end

    assign walk_left  = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah       = (state == FALL_R) || (state == FALL_L);
    assign digging    = (state == DIG_R) || (state == DIG_L);
endmodule
