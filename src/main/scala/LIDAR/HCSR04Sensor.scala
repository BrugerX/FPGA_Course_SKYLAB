package LIDAR

import chisel3._

// ALU-like object for turning clock cycles into distances
class HCSR04Sensor() extends Module {
  val io = IO(new Bundle {
    val start_reading = Input(Bool())
    val restart = Input(Bool())

    //Measured distance in CM * 10^6
    val dist_cm = Output(UInt(32.W))

    //For testing
    val physical_echo_test = Input(Bool())
    val sig_counter = Output(UInt(32.W))
  })

  // Speed of sound in air = 0.0034
  // In order to get the original estimate divide by 10^6
  // Units: cm/cc
  val dist_calculator = Module(new DistanceCalculator())
  val signal_counter = Module(new SignalCounter(width = 32))

  io.dist_cm := dist_calculator.io.distance_cm

  val reg_echo = RegInit(false.B)
  val reg_start = RegInit(false.B)

  reg_start := io.start_reading
  reg_echo := io.physical_echo_test

  //We restart the counter when we request a new reading
  signal_counter.io.reset := io.restart

  //We have one clock cycle's inaccuracy if we only read from the register
  // Started but haven't gotten echo back
  signal_counter.io.signal := (reg_start && !(reg_echo || io.physical_echo_test))

  //TODO: Consider just letting it be the signal counter out permanently; That way we can gradually see the distance increase
  dist_calculator.io.clock_cycles := Mux((reg_echo || io.physical_echo_test),signal_counter.io.out,0.U)
  io.sig_counter := signal_counter.io.out
}