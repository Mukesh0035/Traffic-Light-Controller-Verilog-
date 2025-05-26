module traffic_light_controller (
    input clk,
    input reset,
    output reg [1:0] ns_light,  // 2'b00 = Red, 2'b01 = Yellow, 2'b10 = Green
    output reg [1:0] ew_light
);

    // State encoding
    parameter S_NS_GREEN  = 2'b00,
              S_NS_YELLOW = 2'b01,
              S_EW_GREEN  = 2'b10,
              S_EW_YELLOW = 2'b11;

    reg [1:0] state, next_state;

    // Timer
    reg [3:0] timer;

    // Timing constants (in number of clock cycles)
    parameter GREEN_TIME  = 4'd5,
              YELLOW_TIME = 4'd2;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_NS_GREEN;
            timer <= 0;
        end else begin
            state <= next_state;

            // Timer management
            if (timer == 0) begin
                case (next_state)
                    S_NS_GREEN, S_EW_GREEN: timer <= GREEN_TIME;
                    S_NS_YELLOW, S_EW_YELLOW: timer <= YELLOW_TIME;
                endcase
            end else begin
                timer <= timer - 1;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_NS_GREEN:  next_state = (timer == 0) ? S_NS_YELLOW : S_NS_GREEN;
            S_NS_YELLOW: next_state = (timer == 0) ? S_EW_GREEN  : S_NS_YELLOW;
            S_EW_GREEN:  next_state = (timer == 0) ? S_EW_YELLOW : S_EW_GREEN;
            S_EW_YELLOW: next_state = (timer == 0) ? S_NS_GREEN  : S_EW_YELLOW;
            default:     next_state = S_NS_GREEN;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S_NS_GREEN:  begin ns_light = 2'b10; ew_light = 2'b00; end // NS Green
            S_NS_YELLOW: begin ns_light = 2'b01; ew_light = 2'b00; end // NS Yellow
            S_EW_GREEN:  begin ns_light = 2'b00; ew_light = 2'b10; end // EW Green
            S_EW_YELLOW: begin ns_light = 2'b00; ew_light = 2'b01; end // EW Yellow
            default:     begin ns_light = 2'b00; ew_light = 2'b00; end
        endcase
    end

endmodule
