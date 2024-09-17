module Trigger(
  input   clock,
  input   reset,
  input   io_start_trigger,
  output  io_trigger_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [9:0] count_reg; // @[Trigger.scala 13:26]
  reg  risingEdge_REG; // @[Trigger.scala 15:47]
  wire  risingEdge = io_start_trigger & ~risingEdge_REG; // @[Trigger.scala 15:37]
  reg  stateReg; // @[Trigger.scala 21:25]
  wire  _GEN_0 = risingEdge | stateReg; // @[Trigger.scala 27:35 28:18 21:25]
  wire [9:0] _count_reg_T_1 = count_reg + 10'h1; // @[Trigger.scala 33:30]
  assign io_trigger_out = ~stateReg ? 1'h0 : stateReg; // @[Trigger.scala 22:18 24:20]
  always @(posedge clock) begin
    if (reset) begin // @[Trigger.scala 13:26]
      count_reg <= 10'h0; // @[Trigger.scala 13:26]
    end else if (~stateReg) begin // @[Trigger.scala 24:20]
      count_reg <= 10'h0; // @[Trigger.scala 26:17]
    end else if (stateReg) begin // @[Trigger.scala 24:20]
      count_reg <= _count_reg_T_1; // @[Trigger.scala 33:17]
    end
    risingEdge_REG <= io_start_trigger; // @[Trigger.scala 15:47]
    if (reset) begin // @[Trigger.scala 21:25]
      stateReg <= 1'h0; // @[Trigger.scala 21:25]
    end else if (~stateReg) begin // @[Trigger.scala 24:20]
      stateReg <= _GEN_0;
    end else if (stateReg) begin // @[Trigger.scala 24:20]
      if (count_reg == 10'h5) begin // @[Trigger.scala 35:33]
        stateReg <= 1'h0; // @[Trigger.scala 36:18]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  count_reg = _RAND_0[9:0];
  _RAND_1 = {1{`RANDOM}};
  risingEdge_REG = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  stateReg = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
