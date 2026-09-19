// tb.v
`timescale 1ns/1ps

module tb;

  // Declare testbench signals
  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
  wire       t_lt;
  wire       t_eq;

  // Instantiate the DUT
  comp2 DUT (
    .A (t_a),
    .B (t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Integer loop counters
  integer i, j;

  // Dynamically drive all 16 input combinations
  initial begin
    t_a = 0;
    t_b = 0;
    #5;

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #10;
      end
    end

    #10;
    $finish;
  end

  // Print results so you can inspect values in the console
  initial begin
    $monitor("Time=%0t | A=%0d (0b%b) | B=%0d (0b%b) | GT=%b | LT=%b | EQ=%b",
             $time, t_a, t_a, t_b, t_b, t_gt, t_lt, t_eq);
  end

endmodule