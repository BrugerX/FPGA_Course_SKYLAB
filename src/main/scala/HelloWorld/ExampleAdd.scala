package HelloWorld

import chisel3._

class ExampleAdd extends Module {
  val io = IO(new Bundle {
    val num1 = Input(UInt(8.W))
    val num2 = Input(UInt(9.W))
    val res = Output(UInt(9.W))
    val overFlow = Output(Bool())
  })

  io.res := io.num1 + io.num2
  io.overFlow := io.res > 255.U


}

object ExampleAddBuild extends App {
  emitVerilog(new ExampleAdd)
}

