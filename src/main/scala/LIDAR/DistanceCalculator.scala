package LIDAR

import chisel3._

// ALU-like object for turning clock cycles into distances
class DistanceCalculator() extends Module {
  val io = IO(new Bundle {
    val clock_cycles = Input(UInt(32.W))

    //Measured distance in CM
    val distance_cm = Output(UInt(32.W))
  })

  // Speed of sound in air = 0.0034
  // In order to get the original estimate divide by 10^6
  // Units: cm/cc
  val v_air = 3400.U(32.W)

  io.distance_cm := (v_air*io.clock_cycles)/2.U
}