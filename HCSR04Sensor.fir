circuit HCSR04Sensor :
  module Trigger :
    input clock : Clock
    input reset : Reset
    output io : { flip start_trigger : UInt<1>, trigger_out : UInt<1>}

    reg count_reg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[Trigger.scala 13:26]
    reg risingEdge_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), risingEdge_REG) @[Trigger.scala 15:47]
    risingEdge_REG <= io.start_trigger @[Trigger.scala 15:47]
    node _risingEdge_T = eq(risingEdge_REG, UInt<1>("h0")) @[Trigger.scala 15:39]
    node risingEdge = and(io.start_trigger, _risingEdge_T) @[Trigger.scala 15:37]
    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Trigger.scala 21:25]
    io.trigger_out <= UInt<1>("h0") @[Trigger.scala 22:18]
    node _T = asUInt(UInt<1>("h0")) @[Trigger.scala 24:20]
    node _T_1 = asUInt(stateReg) @[Trigger.scala 24:20]
    node _T_2 = eq(_T, _T_1) @[Trigger.scala 24:20]
    when _T_2 : @[Trigger.scala 24:20]
      count_reg <= UInt<1>("h0") @[Trigger.scala 26:17]
      node _T_3 = eq(risingEdge, UInt<1>("h1")) @[Trigger.scala 27:23]
      when _T_3 : @[Trigger.scala 27:35]
        stateReg <= UInt<1>("h1") @[Trigger.scala 28:18]
    else :
      node _T_4 = asUInt(UInt<1>("h1")) @[Trigger.scala 24:20]
      node _T_5 = asUInt(stateReg) @[Trigger.scala 24:20]
      node _T_6 = eq(_T_4, _T_5) @[Trigger.scala 24:20]
      when _T_6 : @[Trigger.scala 24:20]
        node _count_reg_T = add(count_reg, UInt<1>("h1")) @[Trigger.scala 33:30]
        node _count_reg_T_1 = tail(_count_reg_T, 1) @[Trigger.scala 33:30]
        count_reg <= _count_reg_T_1 @[Trigger.scala 33:17]
        io.trigger_out <= UInt<1>("h1") @[Trigger.scala 34:22]
        node _T_7 = eq(count_reg, UInt<3>("h5")) @[Trigger.scala 35:23]
        when _T_7 : @[Trigger.scala 35:33]
          stateReg <= UInt<1>("h0") @[Trigger.scala 36:18]


  module DistanceCalculator :
    input clock : Clock
    input reset : Reset
    output io : { flip clock_cycles : UInt<32>, distance_cm : UInt<32>}

    node _io_distance_cm_T = mul(UInt<32>("hd48"), io.clock_cycles) @[DistanceCalculator.scala 21:27]
    node _io_distance_cm_T_1 = div(_io_distance_cm_T, UInt<2>("h2")) @[DistanceCalculator.scala 21:44]
    io.distance_cm <= _io_distance_cm_T_1 @[DistanceCalculator.scala 21:18]

  module SignalCounter :
    input clock : Clock
    input reset : Reset
    output io : { flip signal : UInt<1>, flip reset : UInt<1>, count : UInt<32>}

    reg counter_reg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[SignalCounter.scala 14:28]
    when io.signal : @[SignalCounter.scala 17:3]
      node _counter_reg_T = add(counter_reg, UInt<1>("h1")) @[SignalCounter.scala 19:51]
      node _counter_reg_T_1 = tail(_counter_reg_T, 1) @[SignalCounter.scala 19:51]
      node _counter_reg_T_2 = mux(io.reset, UInt<1>("h0"), _counter_reg_T_1) @[SignalCounter.scala 19:23]
      counter_reg <= _counter_reg_T_2 @[SignalCounter.scala 19:17]
    io.count <= counter_reg @[SignalCounter.scala 22:12]

  module HCSR04Sensor :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip start_reading : UInt<1>, sensor_measurement : UInt<16>, sensor_trigger_pin : UInt<1>, flip physical_echo_test : UInt<1>}

    inst sensor_trigger of Trigger @[HCSR04Sensor.scala 32:30]
    sensor_trigger.clock <= clock
    sensor_trigger.reset <= reset
    inst dist_calculator of DistanceCalculator @[HCSR04Sensor.scala 37:31]
    dist_calculator.clock <= clock
    dist_calculator.reset <= reset
    inst signal_counter of SignalCounter @[HCSR04Sensor.scala 38:30]
    signal_counter.clock <= clock
    signal_counter.reset <= reset
    reg reg_echo : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_echo) @[HCSR04Sensor.scala 41:21]
    reg reg_signal : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_signal) @[HCSR04Sensor.scala 42:23]
    reg reg_output : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_output) @[HCSR04Sensor.scala 43:23]
    sensor_trigger.io.start_trigger <= io.start_reading @[HCSR04Sensor.scala 46:35]
    io.sensor_trigger_pin <= sensor_trigger.io.trigger_out @[HCSR04Sensor.scala 47:25]
    reg_signal <= io.start_reading @[HCSR04Sensor.scala 50:14]
    node _io_sensor_measurement_T = dshr(reg_output, UInt<5>("h10")) @[HCSR04Sensor.scala 51:39]
    io.sensor_measurement <= _io_sensor_measurement_T @[HCSR04Sensor.scala 51:25]
    signal_counter.io.reset <= reg_signal @[HCSR04Sensor.scala 54:27]
    node _reg_echo_T = mux(reg_signal, UInt<1>("h0"), io.physical_echo_test) @[HCSR04Sensor.scala 56:18]
    reg_echo <= _reg_echo_T @[HCSR04Sensor.scala 56:12]
    node _reg_output_T = mux(reg_signal, UInt<1>("h0"), dist_calculator.io.distance_cm) @[HCSR04Sensor.scala 57:20]
    reg_output <= _reg_output_T @[HCSR04Sensor.scala 57:14]
    node _echo_registered_T = or(reg_echo, io.physical_echo_test) @[HCSR04Sensor.scala 60:42]
    node echo_registered = eq(_echo_registered_T, UInt<1>("h0")) @[HCSR04Sensor.scala 60:31]
    node _signal_counter_io_signal_T = mux(echo_registered, UInt<1>("h1"), UInt<1>("h0")) @[HCSR04Sensor.scala 62:34]
    signal_counter.io.signal <= _signal_counter_io_signal_T @[HCSR04Sensor.scala 62:28]
    node _dist_calculator_io_clock_cycles_T = mux(echo_registered, UInt<32>("h0"), signal_counter.io.count) @[HCSR04Sensor.scala 64:41]
    dist_calculator.io.clock_cycles <= _dist_calculator_io_clock_cycles_T @[HCSR04Sensor.scala 64:35]

