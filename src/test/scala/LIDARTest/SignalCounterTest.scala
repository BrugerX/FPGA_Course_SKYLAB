import LIDAR.SignalCounter
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class SignalCounterTest extends AnyFlatSpec with ChiselScalatestTester {
  "Signalcounter" should "pass" in {
    test(new SignalCounter(width = 10)).withAnnotations(Seq(WriteVcdAnnotation))
    { dut =>
      /*
      var test_max_count: Int = 3
      var before_step = dut.io.count.peekInt()
      dut.clock.step(1)
      //It should not be the clock, that determines if we step or not
      assert(dut.io.count.peekInt() == before_step)
      dut.io.signal.poke(true.B)
      dut.clock.step(1)
      assert(dut.io.count.peekInt() != before_step)
      assert(dut.io.count.peekInt() == 1)
      dut.clock.step(test_max_count-1)
      assert(dut.io.count.peekInt() == test_max_count)
      dut.clock.step(1)
      assert(dut.io.count.peekInt() == 0)
      dut.clock.step(test_max_count+1)
      assert(dut.io.count.peekInt() == 0)*/
      dut.io.reset.poke(false.B)
      dut.io.signal.poke(false.B)
      dut.clock.step(1)
      dut.io.reset.poke(false.B)
      dut.io.signal.poke(true.B)
      dut.clock.step(5)
      dut.io.reset.poke(false.B)
      dut.io.signal.poke(false.B)
      dut.clock.step(5)
      dut.io.reset.poke(true.B)
      dut.io.signal.poke(false.B)
      dut.clock.step(5)

    }
  }
}
