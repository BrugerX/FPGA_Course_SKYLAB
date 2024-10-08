package LIDAR

import chisel3._

// ALU-like object for turning clock cycles into distances
class HCSR04Sensor() extends Module {
  val io = IO(new Bundle {
    val start_reading = Input(Bool())

    //Measured distance in CM * 10^6
    val sensor_measurement = Output(UInt(8.W))

    //To send trigger signal
    val sensor_trigger_pin = Output(Bool())

    //For testing
    val physical_echo_test = Input(Bool())
  })



  def distance(clock_cycles: UInt) = {

    // Speed of sound in air = 0.0034
    // In order to get the original estimate divide by 10^6
    // Units: cm/cc
    val v_air = 3400.U(32.W)


    //Implicit return statement
    (v_air * clock_cycles) / 2.U


  }
  //Adds trigger local to sensor might be changed so very sensor shares trigger
  val sensor_trigger = Module(new Trigger())

  // Speed of sound in air = 0.0034
  // In order to get the original estimate divide by 10^6
  // Units: cm/cc
  val dist_calculator = Module(new DistanceCalculator())
  val signal_counter = Module(new SignalCounter(width = 32))

  //Define the registers
  val reg_echo = Reg(Bool())
  val reg_signal = Reg(Bool())
  val reg_output = Reg(UInt(32.W))

  //TODO add timeout for no return

  //Hookup Sensor
  sensor_trigger.io.start_trigger := io.start_reading
  io.sensor_trigger_pin := sensor_trigger.io.trigger_out

  //Hookup registers to their top level I/O
  reg_signal := io.start_reading
  io.sensor_measurement := reg_output

  val risingEdge = io.start_reading && !RegNext(io.start_reading)

  signal_counter.io.reset := false.B

  when(risingEdge) {
      signal_counter.io.reset := true.B
  }

  //Hook up all the reset pins
  signal_counter.io.signal := io.physical_echo_test
  io.sensor_measurement := signal_counter.io.count


  dist_calculator.io.clock_cycles := signal_counter.io.count
  io.sensor_measurement := dist_calculator.io.distance_cm
  /*
 //Remember: Reset is just a mux to select 0 when we activate it
 reg_echo := Mux(reg_signal,0.U,io.physical_echo_test)
 reg_output := Mux(reg_signal,0.U,dist_calculator.io.distance_cm)



 //We reuse this value, so make it a variable
 val echo_registered: Bool = !(reg_echo || io.physical_echo_test)
 //Hookup signal counter sig pin
 signal_counter.io.signal := Mux(echo_registered,1.B,0.B)
 //Hookup clock cycles to dist calculator
 dist_calculator.io.clock_cycles := Mux(echo_registered,0.U(32.W),signal_counter.io.count)*/
}

object SensorBuild extends App {
  emitVerilog(new HCSR04Sensor())
}