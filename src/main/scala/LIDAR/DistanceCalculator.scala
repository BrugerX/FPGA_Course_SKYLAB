package LIDAR

import chisel3._



// ALU-like object for turning clock cycles into distances
class DistanceCalculator() extends Module {
  val io = IO(new Bundle {
    val clock_cycles = Input(UInt(32.W))

    //Measured distance in CM
    val distance_cm = Output(UInt(8.W))
  })

  // Speed of sound in air = 0.00343
  // In order to get the original estimate divide by 10^6.
  // But because non power of 2 division is tough we multiply by (2^20/10^6) to make divion by 2^20 nice. This is why v_air is weird.
  // Units: cm/cc
  val v_air = 360.U(32.W)

  io.distance_cm := ((v_air*io.clock_cycles)/2.U) >> 20
}

