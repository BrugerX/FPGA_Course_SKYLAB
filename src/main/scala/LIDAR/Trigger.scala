package LIDAR

import chisel3._
import chisel3.util._

class Trigger() extends Module {
  val io = IO(new Bundle {
    val start_trigger = Input(Bool())

    val trigger_out = Output(Bool())
  })
  val count_reg = RegInit(0.U(10.W))

  val risingEdge = io.start_trigger & !RegNext(io.start_trigger)

  object State extends ChiselEnum {
    val idle, send = Value
  }
  import State._
  val stateReg = RegInit(idle)
  io.trigger_out := false.B

  switch(stateReg) {
    is(idle) {
      count_reg := 0.U
      when(risingEdge === true.B) {
        stateReg := send
      }
    }
    is(send) {
      //TODO compute er done. Få implementeret handshake
      count_reg := count_reg + 1.U
      io.trigger_out := true.B
      when (count_reg === 1000.U) {
        stateReg := idle
      }
    }
  }
}

object TriggerBuild extends App {
  emitVerilog(new Trigger())
}