module led (
    input sys_clk,          // clk input
    input sys_rst_n,        // reset input
    output reg [5:0] led    // 6 LEDS pin
);

reg [25:0] counter;

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        counter <= 26'd0;
    else if (counter < 26'd27000000)       // 0.5s delay
        counter <= counter + 1'd1;
    else
        counter <= 26'd0;
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if (!sys_rst_n)
        led <= 6'b111111;
    else if (counter == 26'd27000000)       // 0.5s delay
        // led[5:0] <= {led[4:0],led[5]}; // Make the lit LED move along the line and wrap around. 
        led[5:0] <= ~led[5:0]; // Just blink all LEDs
    else
        led <= led; // Superfluous?
end

endmodule
