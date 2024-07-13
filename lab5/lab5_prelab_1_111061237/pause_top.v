module pause_top(
    clk, // Clock from crystal
    reset, //active low reset
    pause_in, //push button input
    counter_enable
);
// Declare I/Os
input clk; // Clock from crystal
input reset; //active low reset
input pause_in; //push button input
output counter_enable;
// Declare internal nodes
wire pb_deb, clk_1, clk_100, clk_s, one_in; // push button debounced out
// Clock generator module
clock_generator U_cg(
    .clk(clk), // clock from crystal
    .reset(reset), // active low reset
    .speedup(1'b0),
    .clk_out1(clk_1), // generated 1 Hz clock
    .clk_out100(clk_100), // generated 100 Hz clock
    .clk_ssd(clk_s)
);
// debounce circuit
debounce_circuit U_dc(
    .clk(clk_100), // clock control
    .reset(reset), // reset
    .pb_in(pause_in), //push button input
    .pb_deb(pb_deb) // debounced push button out
);
   // 1 pulse generation circuit
one_pulse U_op(
    .clk(clk), // clock input
    .reset(reset), //active low reset
    .in_trig(pb_deb), // input trigger
    .out_pulse(one_in) // output one pulse
);
pause_fsm U_pf(
    .clk(clk),
    .reset(reset),
    .in(one_in),
    .count_enable(counter_enable)
);
endmodule
   