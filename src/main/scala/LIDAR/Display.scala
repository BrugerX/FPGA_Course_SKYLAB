package LIDAR

import chisel3._
import chisel3.util._

class Display extends Module {
  val io = IO(new Bundle {
    val sum = Input(UInt(8.W))
    val price = Input(UInt(8.W))
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
  })

  // Onehot coded
  val digiSelect = RegInit("b0001".U(4.W))

  val clockReg = RegInit(0.U(20.W))
  clockReg := clockReg + 1.U
  when (clockReg === 10000.U) {
    clockReg := 0.U
    // Rotary shift on digiSelect
    digiSelect := digiSelect(2, 0) ## digiSelect(3)
  }

  // Binary to Binary digit, for price and sum
  val PriceBin2BDC = Module(new Bin2BDC)
  PriceBin2BDC.io.N := io.price
  val SumBin2BDC = Module(new Bin2BDC)
  SumBin2BDC.io.N := io.sum

  // SevenSegDecoder of selected digit
  val sevenSegDec = Module(new SevenSegDecoder)

  // One-hot coded mux to select digit (digit represented in binary [0, 9])
  val digits = Seq(PriceBin2BDC.io.D0, PriceBin2BDC.io.D1, SumBin2BDC.io.D0, SumBin2BDC.io.D1)
  sevenSegDec.io.in := Mux1H(digiSelect, digits)

  // Output connection
  io.seg := ~sevenSegDec.io.out
  io.an := ~digiSelect
}

// Given a binary number, N, in [0, 99], returns 2 binary numbers, D0, D1, both in [0, 9],
// where N = 10*D1 + D0
class Bin2BDC extends Module {
  val io = IO(new Bundle {
    val N = Input(UInt(7.W))    // [0, 99]
    val D0 = Output(UInt(4.W))  // [0, 9]
    val D1 = Output(UInt(4.W))  // [0, 9]
  })

  val table = Wire(Vec(100, Vec(2, UInt(4.W))))

  // Creation of the table
  for(i <- 0 until 100) {
    table(i)(0) := (i%10).U
    table(i)(1) := (i/10).U
  }

  io.D0 := table(io.N)(0)
  io.D1 := table(io.N)(1)
}

class SevenSegDecoder extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(4.W))
    val out = Output(UInt(7.W))
  })

  val sevSeg = WireDefault(0.U(7.W))

  // A vector with encoding for 7 seg display
  val displayEncoding = Wire(Vec(16, UInt(7.W)))
  displayEncoding(0) :=   "b0111111".U
  displayEncoding(1) :=   "b0000110".U
  displayEncoding(2) :=   "b1011011".U
  displayEncoding(3) :=   "b1001111".U
  displayEncoding(4) :=   "b1100110".U
  displayEncoding(5) :=   "b1101101".U
  displayEncoding(6) :=   "b1111101".U
  displayEncoding(7) :=   "b0000111".U
  displayEncoding(8) :=   "b1111111".U
  displayEncoding(9) :=   "b1100111".U
  displayEncoding(10) :=  "b1110111".U
  displayEncoding(11) :=  "b1111100".U
  displayEncoding(12) :=  "b0111001".U
  displayEncoding(13) :=  "b1011110".U
  displayEncoding(14) :=  "b1111001".U
  displayEncoding(15) :=  "b1110001".U

  sevSeg := displayEncoding(io.in)

  io.out := sevSeg
}

class Hello extends Module {
  val io = IO(new Bundle {
    val led = Output (UInt (1.W))
  })
  val CNT_MAX = (50000000 / 2 - 1).U
  val cntReg = RegInit (0.U(32.W))
  val blkReg = RegInit (0.U(1.W))
  cntReg := cntReg + 1.U
  when(cntReg === CNT_MAX ) {
    cntReg := 0.U
    blkReg := ~blkReg
  }
  io.led := blkReg
}

// generate Verilog
object Display extends App {
  emitVerilog(new Display)
}

