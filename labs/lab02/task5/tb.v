// tb.v

module tb;

  // Declare testbench signals
  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  // Instantiate the DUT
  alu DUT (
    .a     (t_a),
    .b     (t_b),
    .op    (t_op),
    .result(t_result)
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
  integer i;

  initial begin
    t_a  = 4'd0;
    t_b  = 4'd0;
    t_op = 1'b0;
    #10;

    // 1. Test Addition (op = 0)
    t_op = 1'b0;
    for (i = 0; i < 4; i = i + 1) begin
      t_a = i + 2;
      t_b = i + 1;
      #10;
    end

    // 2. Test Subtraction (op = 1)
    t_op = 1'b1;
    for (i = 0; i < 4; i = i + 1) begin
      t_a = 4'd8;
      t_b = i + 1;
      #10;
    end

    // 3. Test changing op while keeping a and b constant
    t_a  = 4'd5;
    t_b  = 4'd2;
    t_op = 1'b0; // Expect: 5 + 2 = 7
    #10;
    t_op = 1'b1; // Expect: 5 - 2 = 3
    #10;

    $finish;
  end

  // Print raw signal values only
  initial begin
    $monitor("Time=%0t | OP=%b | A=%0d | B=%0d | RESULT=%0d (bin: %b)",
             $time, t_op, t_a, t_b, t_result, t_result);
  end

endmodule