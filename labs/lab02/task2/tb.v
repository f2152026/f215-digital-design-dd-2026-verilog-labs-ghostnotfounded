// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  localparam WIDTH = 8;
  localparam DEPTH = 4;

  // TODO: declare the inputs and outputs
  reg [$clog2(DEPTH)-1:0]   t_sel;
  wire [WIDTH-1:0]          t_dout;

  // TODO: instantiate DUT here
  lut #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
  ) DUT (
    .sel (t_sel),
    .dout(t_dout)
  );
  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer idx;
  initial begin
    // TODO: apply different input combinations
    t_sel = 0;
    #5;

    for (idx = 0; idx < DEPTH; idx = idx + 1) begin
      t_sel = idx;
      #5;
    end

    #10;

  end

  initial
    $monitor($time, " SEL=%b | DOUT=%b", t_sel, t_dout); // change as required

endmodule
