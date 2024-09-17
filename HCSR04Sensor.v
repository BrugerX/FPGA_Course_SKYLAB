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
module DistanceCalculator(
  input  [31:0] io_clock_cycles,
  output [31:0] io_distance_cm
);
  wire [63:0] _io_distance_cm_T = 32'hd48 * io_clock_cycles; // @[DistanceCalculator.scala 21:27]
  wire [63:0] _io_distance_cm_T_1 = _io_distance_cm_T / 2'h2; // @[DistanceCalculator.scala 21:44]
  assign io_distance_cm = _io_distance_cm_T_1[31:0]; // @[DistanceCalculator.scala 21:18]
endmodule
module SignalCounter(
  input         clock,
  input         reset,
  input         io_signal,
  input         io_reset,
  output [31:0] io_count
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] counter_reg; // @[SignalCounter.scala 14:28]
  wire [31:0] _counter_reg_T_1 = counter_reg + 32'h1; // @[SignalCounter.scala 19:51]
  assign io_count = counter_reg; // @[SignalCounter.scala 22:12]
  always @(posedge clock) begin
    if (reset) begin // @[SignalCounter.scala 14:28]
      counter_reg <= 32'h0; // @[SignalCounter.scala 14:28]
    end else if (io_signal) begin // @[SignalCounter.scala 17:3]
      if (io_reset) begin // @[SignalCounter.scala 19:23]
        counter_reg <= 32'h0;
      end else begin
        counter_reg <= _counter_reg_T_1;
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
  counter_reg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module HCSR04Sensor(
  input         clock,
  input         reset,
  input         io_start_reading,
  output [15:0] io_sensor_measurement,
  output        io_sensor_trigger_pin,
  input         io_physical_echo_test
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  sensor_trigger_clock; // @[HCSR04Sensor.scala 32:30]
  wire  sensor_trigger_reset; // @[HCSR04Sensor.scala 32:30]
  wire  sensor_trigger_io_start_trigger; // @[HCSR04Sensor.scala 32:30]
  wire  sensor_trigger_io_trigger_out; // @[HCSR04Sensor.scala 32:30]
  wire [31:0] dist_calculator_io_clock_cycles; // @[HCSR04Sensor.scala 37:31]
  wire [31:0] dist_calculator_io_distance_cm; // @[HCSR04Sensor.scala 37:31]
  wire  signal_counter_clock; // @[HCSR04Sensor.scala 38:30]
  wire  signal_counter_reset; // @[HCSR04Sensor.scala 38:30]
  wire  signal_counter_io_signal; // @[HCSR04Sensor.scala 38:30]
  wire  signal_counter_io_reset; // @[HCSR04Sensor.scala 38:30]
  wire [31:0] signal_counter_io_count; // @[HCSR04Sensor.scala 38:30]
  reg  reg_echo; // @[HCSR04Sensor.scala 41:21]
  reg  reg_signal; // @[HCSR04Sensor.scala 42:23]
  reg [31:0] reg_output; // @[HCSR04Sensor.scala 43:23]
  wire [31:0] _io_sensor_measurement_T = {{16'd0}, reg_output[31:16]}; // @[HCSR04Sensor.scala 51:39]
  wire  echo_registered = ~(reg_echo | io_physical_echo_test); // @[HCSR04Sensor.scala 60:31]
  Trigger sensor_trigger ( // @[HCSR04Sensor.scala 32:30]
    .clock(sensor_trigger_clock),
    .reset(sensor_trigger_reset),
    .io_start_trigger(sensor_trigger_io_start_trigger),
    .io_trigger_out(sensor_trigger_io_trigger_out)
  );
  DistanceCalculator dist_calculator ( // @[HCSR04Sensor.scala 37:31]
    .io_clock_cycles(dist_calculator_io_clock_cycles),
    .io_distance_cm(dist_calculator_io_distance_cm)
  );
  SignalCounter signal_counter ( // @[HCSR04Sensor.scala 38:30]
    .clock(signal_counter_clock),
    .reset(signal_counter_reset),
    .io_signal(signal_counter_io_signal),
    .io_reset(signal_counter_io_reset),
    .io_count(signal_counter_io_count)
  );
  assign io_sensor_measurement = _io_sensor_measurement_T[15:0]; // @[HCSR04Sensor.scala 51:25]
  assign io_sensor_trigger_pin = sensor_trigger_io_trigger_out; // @[HCSR04Sensor.scala 47:25]
  assign sensor_trigger_clock = clock;
  assign sensor_trigger_reset = reset;
  assign sensor_trigger_io_start_trigger = io_start_reading; // @[HCSR04Sensor.scala 46:35]
  assign dist_calculator_io_clock_cycles = echo_registered ? 32'h0 : signal_counter_io_count; // @[HCSR04Sensor.scala 64:41]
  assign signal_counter_clock = clock;
  assign signal_counter_reset = reset;
  assign signal_counter_io_signal = ~(reg_echo | io_physical_echo_test); // @[HCSR04Sensor.scala 60:31]
  assign signal_counter_io_reset = reg_signal; // @[HCSR04Sensor.scala 54:27]
  always @(posedge clock) begin
    if (reg_signal) begin // @[HCSR04Sensor.scala 56:18]
      reg_echo <= 1'h0;
    end else begin
      reg_echo <= io_physical_echo_test;
    end
    reg_signal <= io_start_reading; // @[HCSR04Sensor.scala 50:14]
    if (reg_signal) begin // @[HCSR04Sensor.scala 57:20]
      reg_output <= 32'h0;
    end else begin
      reg_output <= dist_calculator_io_distance_cm;
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
  reg_echo = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_signal = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  reg_output = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
