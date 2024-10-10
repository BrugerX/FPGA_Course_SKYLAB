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
  reg [9:0] count_reg; // @[Trigger.scala 12:26]
  reg  risingEdge_REG; // @[Trigger.scala 14:47]
  wire  risingEdge = io_start_trigger & ~risingEdge_REG; // @[Trigger.scala 14:37]
  reg  stateReg; // @[Trigger.scala 20:25]
  wire  _GEN_0 = risingEdge | stateReg; // @[Trigger.scala 26:35 27:18 20:25]
  wire [9:0] _count_reg_T_1 = count_reg + 10'h1; // @[Trigger.scala 32:30]
  assign io_trigger_out = ~stateReg ? 1'h0 : stateReg; // @[Trigger.scala 21:18 23:20]
  always @(posedge clock) begin
    if (reset) begin // @[Trigger.scala 12:26]
      count_reg <= 10'h0; // @[Trigger.scala 12:26]
    end else if (~stateReg) begin // @[Trigger.scala 23:20]
      count_reg <= 10'h0; // @[Trigger.scala 25:17]
    end else if (stateReg) begin // @[Trigger.scala 23:20]
      count_reg <= _count_reg_T_1; // @[Trigger.scala 32:17]
    end
    risingEdge_REG <= io_start_trigger; // @[Trigger.scala 14:47]
    if (reset) begin // @[Trigger.scala 20:25]
      stateReg <= 1'h0; // @[Trigger.scala 20:25]
    end else if (~stateReg) begin // @[Trigger.scala 23:20]
      stateReg <= _GEN_0;
    end else if (stateReg) begin // @[Trigger.scala 23:20]
      if (count_reg == 10'h3e8) begin // @[Trigger.scala 34:35]
        stateReg <= 1'h0; // @[Trigger.scala 35:18]
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
  output [7:0]  io_distance_cm
);
  wire [63:0] _io_distance_cm_T = 32'h168 * io_clock_cycles; // @[DistanceCalculator.scala 22:28]
  wire [63:0] _io_distance_cm_T_1 = _io_distance_cm_T / 2'h2; // @[DistanceCalculator.scala 22:45]
  assign io_distance_cm = _io_distance_cm_T_1[27:20]; // @[DistanceCalculator.scala 22:18]
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
  wire [31:0] _GEN_0 = {{31'd0}, io_signal}; // @[SignalCounter.scala 17:49]
  wire [31:0] _counter_reg_T_1 = counter_reg + _GEN_0; // @[SignalCounter.scala 17:49]
  assign io_count = counter_reg; // @[SignalCounter.scala 19:12]
  always @(posedge clock) begin
    if (reset) begin // @[SignalCounter.scala 14:28]
      counter_reg <= 32'h0; // @[SignalCounter.scala 14:28]
    end else if (io_reset) begin // @[SignalCounter.scala 17:21]
      counter_reg <= 32'h0;
    end else begin
      counter_reg <= _counter_reg_T_1;
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
  input        clock,
  input        reset,
  input        io_start_reading,
  output [7:0] io_sensor_measurement,
  output       io_sensor_trigger_pin,
  input        io_physical_echo_test
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  sensor_trigger_clock; // @[HCSR04Sensor.scala 36:30]
  wire  sensor_trigger_reset; // @[HCSR04Sensor.scala 36:30]
  wire  sensor_trigger_io_start_trigger; // @[HCSR04Sensor.scala 36:30]
  wire  sensor_trigger_io_trigger_out; // @[HCSR04Sensor.scala 36:30]
  wire [31:0] dist_calculator_io_clock_cycles; // @[HCSR04Sensor.scala 41:31]
  wire [7:0] dist_calculator_io_distance_cm; // @[HCSR04Sensor.scala 41:31]
  wire  signal_counter_clock; // @[HCSR04Sensor.scala 42:30]
  wire  signal_counter_reset; // @[HCSR04Sensor.scala 42:30]
  wire  signal_counter_io_signal; // @[HCSR04Sensor.scala 42:30]
  wire  signal_counter_io_reset; // @[HCSR04Sensor.scala 42:30]
  wire [31:0] signal_counter_io_count; // @[HCSR04Sensor.scala 42:30]
  reg  risingEdge_REG; // @[HCSR04Sensor.scala 59:48]
  Trigger sensor_trigger ( // @[HCSR04Sensor.scala 36:30]
    .clock(sensor_trigger_clock),
    .reset(sensor_trigger_reset),
    .io_start_trigger(sensor_trigger_io_start_trigger),
    .io_trigger_out(sensor_trigger_io_trigger_out)
  );
  DistanceCalculator dist_calculator ( // @[HCSR04Sensor.scala 41:31]
    .io_clock_cycles(dist_calculator_io_clock_cycles),
    .io_distance_cm(dist_calculator_io_distance_cm)
  );
  SignalCounter signal_counter ( // @[HCSR04Sensor.scala 42:30]
    .clock(signal_counter_clock),
    .reset(signal_counter_reset),
    .io_signal(signal_counter_io_signal),
    .io_reset(signal_counter_io_reset),
    .io_count(signal_counter_io_count)
  );
  assign io_sensor_measurement = dist_calculator_io_distance_cm; // @[HCSR04Sensor.scala 73:25]
  assign io_sensor_trigger_pin = sensor_trigger_io_trigger_out; // @[HCSR04Sensor.scala 53:25]
  assign sensor_trigger_clock = clock;
  assign sensor_trigger_reset = reset;
  assign sensor_trigger_io_start_trigger = io_start_reading; // @[HCSR04Sensor.scala 52:35]
  assign dist_calculator_io_clock_cycles = signal_counter_io_count; // @[HCSR04Sensor.scala 72:35]
  assign signal_counter_clock = clock;
  assign signal_counter_reset = reset;
  assign signal_counter_io_signal = io_physical_echo_test; // @[HCSR04Sensor.scala 68:28]
  assign signal_counter_io_reset = io_start_reading & ~risingEdge_REG; // @[HCSR04Sensor.scala 59:37]
  always @(posedge clock) begin
    risingEdge_REG <= io_start_reading; // @[HCSR04Sensor.scala 59:48]
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
  risingEdge_REG = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Bin2BDC(
  input  [6:0] io_N,
  output [3:0] io_D0,
  output [3:0] io_D1
);
  wire [3:0] _GEN_1 = 7'h1 == io_N ? 4'h1 : 4'h0; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_2 = 7'h2 == io_N ? 4'h2 : _GEN_1; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_3 = 7'h3 == io_N ? 4'h3 : _GEN_2; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_4 = 7'h4 == io_N ? 4'h4 : _GEN_3; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_5 = 7'h5 == io_N ? 4'h5 : _GEN_4; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_6 = 7'h6 == io_N ? 4'h6 : _GEN_5; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_7 = 7'h7 == io_N ? 4'h7 : _GEN_6; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_8 = 7'h8 == io_N ? 4'h8 : _GEN_7; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_9 = 7'h9 == io_N ? 4'h9 : _GEN_8; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_10 = 7'ha == io_N ? 4'h0 : _GEN_9; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_11 = 7'hb == io_N ? 4'h1 : _GEN_10; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_12 = 7'hc == io_N ? 4'h2 : _GEN_11; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_13 = 7'hd == io_N ? 4'h3 : _GEN_12; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_14 = 7'he == io_N ? 4'h4 : _GEN_13; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_15 = 7'hf == io_N ? 4'h5 : _GEN_14; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_16 = 7'h10 == io_N ? 4'h6 : _GEN_15; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_17 = 7'h11 == io_N ? 4'h7 : _GEN_16; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_18 = 7'h12 == io_N ? 4'h8 : _GEN_17; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_19 = 7'h13 == io_N ? 4'h9 : _GEN_18; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_20 = 7'h14 == io_N ? 4'h0 : _GEN_19; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_21 = 7'h15 == io_N ? 4'h1 : _GEN_20; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_22 = 7'h16 == io_N ? 4'h2 : _GEN_21; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_23 = 7'h17 == io_N ? 4'h3 : _GEN_22; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_24 = 7'h18 == io_N ? 4'h4 : _GEN_23; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_25 = 7'h19 == io_N ? 4'h5 : _GEN_24; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_26 = 7'h1a == io_N ? 4'h6 : _GEN_25; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_27 = 7'h1b == io_N ? 4'h7 : _GEN_26; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_28 = 7'h1c == io_N ? 4'h8 : _GEN_27; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_29 = 7'h1d == io_N ? 4'h9 : _GEN_28; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_30 = 7'h1e == io_N ? 4'h0 : _GEN_29; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_31 = 7'h1f == io_N ? 4'h1 : _GEN_30; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_32 = 7'h20 == io_N ? 4'h2 : _GEN_31; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_33 = 7'h21 == io_N ? 4'h3 : _GEN_32; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_34 = 7'h22 == io_N ? 4'h4 : _GEN_33; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_35 = 7'h23 == io_N ? 4'h5 : _GEN_34; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_36 = 7'h24 == io_N ? 4'h6 : _GEN_35; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_37 = 7'h25 == io_N ? 4'h7 : _GEN_36; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_38 = 7'h26 == io_N ? 4'h8 : _GEN_37; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_39 = 7'h27 == io_N ? 4'h9 : _GEN_38; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_40 = 7'h28 == io_N ? 4'h0 : _GEN_39; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_41 = 7'h29 == io_N ? 4'h1 : _GEN_40; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_42 = 7'h2a == io_N ? 4'h2 : _GEN_41; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_43 = 7'h2b == io_N ? 4'h3 : _GEN_42; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_44 = 7'h2c == io_N ? 4'h4 : _GEN_43; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_45 = 7'h2d == io_N ? 4'h5 : _GEN_44; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_46 = 7'h2e == io_N ? 4'h6 : _GEN_45; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_47 = 7'h2f == io_N ? 4'h7 : _GEN_46; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_48 = 7'h30 == io_N ? 4'h8 : _GEN_47; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_49 = 7'h31 == io_N ? 4'h9 : _GEN_48; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_50 = 7'h32 == io_N ? 4'h0 : _GEN_49; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_51 = 7'h33 == io_N ? 4'h1 : _GEN_50; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_52 = 7'h34 == io_N ? 4'h2 : _GEN_51; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_53 = 7'h35 == io_N ? 4'h3 : _GEN_52; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_54 = 7'h36 == io_N ? 4'h4 : _GEN_53; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_55 = 7'h37 == io_N ? 4'h5 : _GEN_54; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_56 = 7'h38 == io_N ? 4'h6 : _GEN_55; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_57 = 7'h39 == io_N ? 4'h7 : _GEN_56; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_58 = 7'h3a == io_N ? 4'h8 : _GEN_57; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_59 = 7'h3b == io_N ? 4'h9 : _GEN_58; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_60 = 7'h3c == io_N ? 4'h0 : _GEN_59; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_61 = 7'h3d == io_N ? 4'h1 : _GEN_60; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_62 = 7'h3e == io_N ? 4'h2 : _GEN_61; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_63 = 7'h3f == io_N ? 4'h3 : _GEN_62; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_64 = 7'h40 == io_N ? 4'h4 : _GEN_63; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_65 = 7'h41 == io_N ? 4'h5 : _GEN_64; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_66 = 7'h42 == io_N ? 4'h6 : _GEN_65; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_67 = 7'h43 == io_N ? 4'h7 : _GEN_66; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_68 = 7'h44 == io_N ? 4'h8 : _GEN_67; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_69 = 7'h45 == io_N ? 4'h9 : _GEN_68; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_70 = 7'h46 == io_N ? 4'h0 : _GEN_69; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_71 = 7'h47 == io_N ? 4'h1 : _GEN_70; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_72 = 7'h48 == io_N ? 4'h2 : _GEN_71; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_73 = 7'h49 == io_N ? 4'h3 : _GEN_72; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_74 = 7'h4a == io_N ? 4'h4 : _GEN_73; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_75 = 7'h4b == io_N ? 4'h5 : _GEN_74; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_76 = 7'h4c == io_N ? 4'h6 : _GEN_75; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_77 = 7'h4d == io_N ? 4'h7 : _GEN_76; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_78 = 7'h4e == io_N ? 4'h8 : _GEN_77; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_79 = 7'h4f == io_N ? 4'h9 : _GEN_78; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_80 = 7'h50 == io_N ? 4'h0 : _GEN_79; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_81 = 7'h51 == io_N ? 4'h1 : _GEN_80; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_82 = 7'h52 == io_N ? 4'h2 : _GEN_81; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_83 = 7'h53 == io_N ? 4'h3 : _GEN_82; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_84 = 7'h54 == io_N ? 4'h4 : _GEN_83; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_85 = 7'h55 == io_N ? 4'h5 : _GEN_84; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_86 = 7'h56 == io_N ? 4'h6 : _GEN_85; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_87 = 7'h57 == io_N ? 4'h7 : _GEN_86; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_88 = 7'h58 == io_N ? 4'h8 : _GEN_87; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_89 = 7'h59 == io_N ? 4'h9 : _GEN_88; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_90 = 7'h5a == io_N ? 4'h0 : _GEN_89; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_91 = 7'h5b == io_N ? 4'h1 : _GEN_90; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_92 = 7'h5c == io_N ? 4'h2 : _GEN_91; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_93 = 7'h5d == io_N ? 4'h3 : _GEN_92; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_94 = 7'h5e == io_N ? 4'h4 : _GEN_93; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_95 = 7'h5f == io_N ? 4'h5 : _GEN_94; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_96 = 7'h60 == io_N ? 4'h6 : _GEN_95; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_97 = 7'h61 == io_N ? 4'h7 : _GEN_96; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_98 = 7'h62 == io_N ? 4'h8 : _GEN_97; // @[Display.scala 60:{9,9}]
  wire [3:0] _GEN_110 = 7'ha == io_N ? 4'h1 : 4'h0; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_111 = 7'hb == io_N ? 4'h1 : _GEN_110; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_112 = 7'hc == io_N ? 4'h1 : _GEN_111; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_113 = 7'hd == io_N ? 4'h1 : _GEN_112; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_114 = 7'he == io_N ? 4'h1 : _GEN_113; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_115 = 7'hf == io_N ? 4'h1 : _GEN_114; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_116 = 7'h10 == io_N ? 4'h1 : _GEN_115; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_117 = 7'h11 == io_N ? 4'h1 : _GEN_116; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_118 = 7'h12 == io_N ? 4'h1 : _GEN_117; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_119 = 7'h13 == io_N ? 4'h1 : _GEN_118; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_120 = 7'h14 == io_N ? 4'h2 : _GEN_119; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_121 = 7'h15 == io_N ? 4'h2 : _GEN_120; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_122 = 7'h16 == io_N ? 4'h2 : _GEN_121; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_123 = 7'h17 == io_N ? 4'h2 : _GEN_122; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_124 = 7'h18 == io_N ? 4'h2 : _GEN_123; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_125 = 7'h19 == io_N ? 4'h2 : _GEN_124; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_126 = 7'h1a == io_N ? 4'h2 : _GEN_125; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_127 = 7'h1b == io_N ? 4'h2 : _GEN_126; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_128 = 7'h1c == io_N ? 4'h2 : _GEN_127; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_129 = 7'h1d == io_N ? 4'h2 : _GEN_128; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_130 = 7'h1e == io_N ? 4'h3 : _GEN_129; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_131 = 7'h1f == io_N ? 4'h3 : _GEN_130; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_132 = 7'h20 == io_N ? 4'h3 : _GEN_131; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_133 = 7'h21 == io_N ? 4'h3 : _GEN_132; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_134 = 7'h22 == io_N ? 4'h3 : _GEN_133; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_135 = 7'h23 == io_N ? 4'h3 : _GEN_134; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_136 = 7'h24 == io_N ? 4'h3 : _GEN_135; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_137 = 7'h25 == io_N ? 4'h3 : _GEN_136; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_138 = 7'h26 == io_N ? 4'h3 : _GEN_137; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_139 = 7'h27 == io_N ? 4'h3 : _GEN_138; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_140 = 7'h28 == io_N ? 4'h4 : _GEN_139; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_141 = 7'h29 == io_N ? 4'h4 : _GEN_140; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_142 = 7'h2a == io_N ? 4'h4 : _GEN_141; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_143 = 7'h2b == io_N ? 4'h4 : _GEN_142; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_144 = 7'h2c == io_N ? 4'h4 : _GEN_143; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_145 = 7'h2d == io_N ? 4'h4 : _GEN_144; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_146 = 7'h2e == io_N ? 4'h4 : _GEN_145; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_147 = 7'h2f == io_N ? 4'h4 : _GEN_146; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_148 = 7'h30 == io_N ? 4'h4 : _GEN_147; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_149 = 7'h31 == io_N ? 4'h4 : _GEN_148; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_150 = 7'h32 == io_N ? 4'h5 : _GEN_149; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_151 = 7'h33 == io_N ? 4'h5 : _GEN_150; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_152 = 7'h34 == io_N ? 4'h5 : _GEN_151; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_153 = 7'h35 == io_N ? 4'h5 : _GEN_152; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_154 = 7'h36 == io_N ? 4'h5 : _GEN_153; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_155 = 7'h37 == io_N ? 4'h5 : _GEN_154; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_156 = 7'h38 == io_N ? 4'h5 : _GEN_155; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_157 = 7'h39 == io_N ? 4'h5 : _GEN_156; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_158 = 7'h3a == io_N ? 4'h5 : _GEN_157; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_159 = 7'h3b == io_N ? 4'h5 : _GEN_158; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_160 = 7'h3c == io_N ? 4'h6 : _GEN_159; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_161 = 7'h3d == io_N ? 4'h6 : _GEN_160; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_162 = 7'h3e == io_N ? 4'h6 : _GEN_161; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_163 = 7'h3f == io_N ? 4'h6 : _GEN_162; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_164 = 7'h40 == io_N ? 4'h6 : _GEN_163; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_165 = 7'h41 == io_N ? 4'h6 : _GEN_164; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_166 = 7'h42 == io_N ? 4'h6 : _GEN_165; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_167 = 7'h43 == io_N ? 4'h6 : _GEN_166; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_168 = 7'h44 == io_N ? 4'h6 : _GEN_167; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_169 = 7'h45 == io_N ? 4'h6 : _GEN_168; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_170 = 7'h46 == io_N ? 4'h7 : _GEN_169; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_171 = 7'h47 == io_N ? 4'h7 : _GEN_170; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_172 = 7'h48 == io_N ? 4'h7 : _GEN_171; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_173 = 7'h49 == io_N ? 4'h7 : _GEN_172; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_174 = 7'h4a == io_N ? 4'h7 : _GEN_173; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_175 = 7'h4b == io_N ? 4'h7 : _GEN_174; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_176 = 7'h4c == io_N ? 4'h7 : _GEN_175; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_177 = 7'h4d == io_N ? 4'h7 : _GEN_176; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_178 = 7'h4e == io_N ? 4'h7 : _GEN_177; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_179 = 7'h4f == io_N ? 4'h7 : _GEN_178; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_180 = 7'h50 == io_N ? 4'h8 : _GEN_179; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_181 = 7'h51 == io_N ? 4'h8 : _GEN_180; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_182 = 7'h52 == io_N ? 4'h8 : _GEN_181; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_183 = 7'h53 == io_N ? 4'h8 : _GEN_182; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_184 = 7'h54 == io_N ? 4'h8 : _GEN_183; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_185 = 7'h55 == io_N ? 4'h8 : _GEN_184; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_186 = 7'h56 == io_N ? 4'h8 : _GEN_185; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_187 = 7'h57 == io_N ? 4'h8 : _GEN_186; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_188 = 7'h58 == io_N ? 4'h8 : _GEN_187; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_189 = 7'h59 == io_N ? 4'h8 : _GEN_188; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_190 = 7'h5a == io_N ? 4'h9 : _GEN_189; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_191 = 7'h5b == io_N ? 4'h9 : _GEN_190; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_192 = 7'h5c == io_N ? 4'h9 : _GEN_191; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_193 = 7'h5d == io_N ? 4'h9 : _GEN_192; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_194 = 7'h5e == io_N ? 4'h9 : _GEN_193; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_195 = 7'h5f == io_N ? 4'h9 : _GEN_194; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_196 = 7'h60 == io_N ? 4'h9 : _GEN_195; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_197 = 7'h61 == io_N ? 4'h9 : _GEN_196; // @[Display.scala 61:{9,9}]
  wire [3:0] _GEN_198 = 7'h62 == io_N ? 4'h9 : _GEN_197; // @[Display.scala 61:{9,9}]
  assign io_D0 = 7'h63 == io_N ? 4'h9 : _GEN_98; // @[Display.scala 60:{9,9}]
  assign io_D1 = 7'h63 == io_N ? 4'h9 : _GEN_198; // @[Display.scala 61:{9,9}]
endmodule
module SevenSegDecoder(
  input  [3:0] io_in,
  output [6:0] io_out
);
  wire [6:0] _GEN_1 = 4'h1 == io_in ? 7'h6 : 7'h3f; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_2 = 4'h2 == io_in ? 7'h5b : _GEN_1; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_3 = 4'h3 == io_in ? 7'h4f : _GEN_2; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_4 = 4'h4 == io_in ? 7'h66 : _GEN_3; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_5 = 4'h5 == io_in ? 7'h6d : _GEN_4; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_6 = 4'h6 == io_in ? 7'h7d : _GEN_5; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_7 = 4'h7 == io_in ? 7'h7 : _GEN_6; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_8 = 4'h8 == io_in ? 7'h7f : _GEN_7; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_9 = 4'h9 == io_in ? 7'h67 : _GEN_8; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_10 = 4'ha == io_in ? 7'h77 : _GEN_9; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_11 = 4'hb == io_in ? 7'h7c : _GEN_10; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_12 = 4'hc == io_in ? 7'h39 : _GEN_11; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_13 = 4'hd == io_in ? 7'h5e : _GEN_12; // @[Display.scala 91:{10,10}]
  wire [6:0] _GEN_14 = 4'he == io_in ? 7'h79 : _GEN_13; // @[Display.scala 91:{10,10}]
  assign io_out = 4'hf == io_in ? 7'h71 : _GEN_14; // @[Display.scala 91:{10,10}]
endmodule
module Display(
  input        clock,
  input        reset,
  input  [7:0] io_sum,
  input  [7:0] io_price,
  output [6:0] io_seg,
  output [3:0] io_an
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [6:0] PriceBin2BDC_io_N; // @[Display.scala 26:28]
  wire [3:0] PriceBin2BDC_io_D0; // @[Display.scala 26:28]
  wire [3:0] PriceBin2BDC_io_D1; // @[Display.scala 26:28]
  wire [6:0] SumBin2BDC_io_N; // @[Display.scala 28:26]
  wire [3:0] SumBin2BDC_io_D0; // @[Display.scala 28:26]
  wire [3:0] SumBin2BDC_io_D1; // @[Display.scala 28:26]
  wire [3:0] sevenSegDec_io_in; // @[Display.scala 32:27]
  wire [6:0] sevenSegDec_io_out; // @[Display.scala 32:27]
  reg [3:0] digiSelect; // @[Display.scala 15:27]
  reg [19:0] clockReg; // @[Display.scala 17:25]
  wire [19:0] _clockReg_T_1 = clockReg + 20'h1; // @[Display.scala 18:24]
  wire [3:0] _digiSelect_T_2 = {digiSelect[2:0],digiSelect[3]}; // @[Display.scala 22:36]
  wire [3:0] _sevenSegDec_io_in_T_4 = digiSelect[0] ? PriceBin2BDC_io_D0 : 4'h0; // @[Mux.scala 27:73]
  wire [3:0] _sevenSegDec_io_in_T_5 = digiSelect[1] ? PriceBin2BDC_io_D1 : 4'h0; // @[Mux.scala 27:73]
  wire [3:0] _sevenSegDec_io_in_T_6 = digiSelect[2] ? SumBin2BDC_io_D0 : 4'h0; // @[Mux.scala 27:73]
  wire [3:0] _sevenSegDec_io_in_T_7 = digiSelect[3] ? SumBin2BDC_io_D1 : 4'h0; // @[Mux.scala 27:73]
  wire [3:0] _sevenSegDec_io_in_T_8 = _sevenSegDec_io_in_T_4 | _sevenSegDec_io_in_T_5; // @[Mux.scala 27:73]
  wire [3:0] _sevenSegDec_io_in_T_9 = _sevenSegDec_io_in_T_8 | _sevenSegDec_io_in_T_6; // @[Mux.scala 27:73]
  Bin2BDC PriceBin2BDC ( // @[Display.scala 26:28]
    .io_N(PriceBin2BDC_io_N),
    .io_D0(PriceBin2BDC_io_D0),
    .io_D1(PriceBin2BDC_io_D1)
  );
  Bin2BDC SumBin2BDC ( // @[Display.scala 28:26]
    .io_N(SumBin2BDC_io_N),
    .io_D0(SumBin2BDC_io_D0),
    .io_D1(SumBin2BDC_io_D1)
  );
  SevenSegDecoder sevenSegDec ( // @[Display.scala 32:27]
    .io_in(sevenSegDec_io_in),
    .io_out(sevenSegDec_io_out)
  );
  assign io_seg = ~sevenSegDec_io_out; // @[Display.scala 39:13]
  assign io_an = ~digiSelect; // @[Display.scala 40:12]
  assign PriceBin2BDC_io_N = io_price[6:0]; // @[Display.scala 27:21]
  assign SumBin2BDC_io_N = io_sum[6:0]; // @[Display.scala 29:19]
  assign sevenSegDec_io_in = _sevenSegDec_io_in_T_9 | _sevenSegDec_io_in_T_7; // @[Mux.scala 27:73]
  always @(posedge clock) begin
    if (reset) begin // @[Display.scala 15:27]
      digiSelect <= 4'h1; // @[Display.scala 15:27]
    end else if (clockReg == 20'h2710) begin // @[Display.scala 19:31]
      digiSelect <= _digiSelect_T_2; // @[Display.scala 22:16]
    end
    if (reset) begin // @[Display.scala 17:25]
      clockReg <= 20'h0; // @[Display.scala 17:25]
    end else if (clockReg == 20'h2710) begin // @[Display.scala 19:31]
      clockReg <= 20'h0; // @[Display.scala 20:14]
    end else begin
      clockReg <= _clockReg_T_1; // @[Display.scala 18:12]
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
  digiSelect = _RAND_0[3:0];
  _RAND_1 = {1{`RANDOM}};
  clockReg = _RAND_1[19:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module LidarTopMain(
  input        clock,
  input        reset,
  output [6:0] io_seg,
  output [3:0] io_an,
  output [7:0] io_sensor_measurement,
  output [7:0] io_sensor_measurement2,
  output       io_sensor_trigger_pin,
  input        io_physical_echo_test,
  input        io_physical_echo_test2
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  sensor_clock; // @[LidarTopMain.scala 22:22]
  wire  sensor_reset; // @[LidarTopMain.scala 22:22]
  wire  sensor_io_start_reading; // @[LidarTopMain.scala 22:22]
  wire [7:0] sensor_io_sensor_measurement; // @[LidarTopMain.scala 22:22]
  wire  sensor_io_sensor_trigger_pin; // @[LidarTopMain.scala 22:22]
  wire  sensor_io_physical_echo_test; // @[LidarTopMain.scala 22:22]
  wire  sensor2_clock; // @[LidarTopMain.scala 23:23]
  wire  sensor2_reset; // @[LidarTopMain.scala 23:23]
  wire  sensor2_io_start_reading; // @[LidarTopMain.scala 23:23]
  wire [7:0] sensor2_io_sensor_measurement; // @[LidarTopMain.scala 23:23]
  wire  sensor2_io_sensor_trigger_pin; // @[LidarTopMain.scala 23:23]
  wire  sensor2_io_physical_echo_test; // @[LidarTopMain.scala 23:23]
  wire  display_clock; // @[LidarTopMain.scala 36:23]
  wire  display_reset; // @[LidarTopMain.scala 36:23]
  wire [7:0] display_io_sum; // @[LidarTopMain.scala 36:23]
  wire [7:0] display_io_price; // @[LidarTopMain.scala 36:23]
  wire [6:0] display_io_seg; // @[LidarTopMain.scala 36:23]
  wire [3:0] display_io_an; // @[LidarTopMain.scala 36:23]
  reg [31:0] regCount; // @[LidarTopMain.scala 25:25]
  wire [31:0] _regCount_T_1 = regCount + 32'h1; // @[LidarTopMain.scala 46:24]
  HCSR04Sensor sensor ( // @[LidarTopMain.scala 22:22]
    .clock(sensor_clock),
    .reset(sensor_reset),
    .io_start_reading(sensor_io_start_reading),
    .io_sensor_measurement(sensor_io_sensor_measurement),
    .io_sensor_trigger_pin(sensor_io_sensor_trigger_pin),
    .io_physical_echo_test(sensor_io_physical_echo_test)
  );
  HCSR04Sensor sensor2 ( // @[LidarTopMain.scala 23:23]
    .clock(sensor2_clock),
    .reset(sensor2_reset),
    .io_start_reading(sensor2_io_start_reading),
    .io_sensor_measurement(sensor2_io_sensor_measurement),
    .io_sensor_trigger_pin(sensor2_io_sensor_trigger_pin),
    .io_physical_echo_test(sensor2_io_physical_echo_test)
  );
  Display display ( // @[LidarTopMain.scala 36:23]
    .clock(display_clock),
    .reset(display_reset),
    .io_sum(display_io_sum),
    .io_price(display_io_price),
    .io_seg(display_io_seg),
    .io_an(display_io_an)
  );
  assign io_seg = display_io_seg; // @[LidarTopMain.scala 37:10]
  assign io_an = display_io_an; // @[LidarTopMain.scala 38:9]
  assign io_sensor_measurement = sensor_io_sensor_measurement; // @[LidarTopMain.scala 29:25]
  assign io_sensor_measurement2 = sensor2_io_sensor_measurement; // @[LidarTopMain.scala 31:26]
  assign io_sensor_trigger_pin = ~sensor_io_sensor_trigger_pin; // @[LidarTopMain.scala 28:28]
  assign sensor_clock = clock;
  assign sensor_reset = reset;
  assign sensor_io_start_reading = regCount == 32'h5f5e100; // @[LidarTopMain.scala 47:17]
  assign sensor_io_physical_echo_test = io_physical_echo_test; // @[LidarTopMain.scala 27:32]
  assign sensor2_clock = clock;
  assign sensor2_reset = reset;
  assign sensor2_io_start_reading = regCount == 32'h5f5e100; // @[LidarTopMain.scala 47:17]
  assign sensor2_io_physical_echo_test = io_physical_echo_test2; // @[LidarTopMain.scala 33:33]
  assign display_clock = clock;
  assign display_reset = reset;
  assign display_io_sum = sensor2_io_sensor_measurement; // @[LidarTopMain.scala 40:18]
  assign display_io_price = sensor_io_sensor_measurement; // @[LidarTopMain.scala 41:20]
  always @(posedge clock) begin
    if (reset) begin // @[LidarTopMain.scala 25:25]
      regCount <= 32'h0; // @[LidarTopMain.scala 25:25]
    end else if (regCount == 32'h5f5e100) begin // @[LidarTopMain.scala 47:34]
      regCount <= 32'h0; // @[LidarTopMain.scala 50:14]
    end else begin
      regCount <= _regCount_T_1; // @[LidarTopMain.scala 46:12]
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
  regCount = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
