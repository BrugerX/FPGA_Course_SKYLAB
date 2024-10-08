package LIDAR
import chisel3._

/*
  |While signal is active, it counts [start,max_count] clock cycles.
*/
class SignalCounter(start_value: Int = 0, width: Int) extends Module {
  val io = IO(new Bundle {
    val signal = Input(Bool())
    val reset = Input(Bool())
    val count = Output(UInt(width.W))
  })

  val counter_reg = RegInit(start_value.U(width.W))

  //Whenever we get the signal; Update the counter_reg
  counter_reg := Mux(io.reset, 0.U ,counter_reg + io.signal)

  io.count := counter_reg
}