`timescale 1ns / 1ps

module tb_traffic_light;

    reg clk;
    reg reset;
    wire [1:0] ns_light;
    wire [1:0] ew_light;

    traffic_light_controller uut (
        .clk(clk),
        .reset(reset),
        .ns_light(ns_light),
        .ew_light(ew_light)
    );

    // Clock: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 1;
        #15;
        reset = 0;

        // Run the controller for a full cycle
        #200;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t | NS=%b | EW=%b", $time, ns_light, ew_light);
    end

endmodule
