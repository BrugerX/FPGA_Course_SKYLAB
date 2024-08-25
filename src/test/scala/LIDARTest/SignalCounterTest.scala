import LIDAR.SignalCounter
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class SignalCounterTest extends AnyFlatSpec with ChiselScalatestTester {
  "Signalcounter" should "pass" in {
    test(new SignalCounter(width = 10))
    { dut =>
      var test_max_count: Int = 3
      var before_step = dut.io.out.peekInt()
      dut.clock.step(1)
      //It should not be the clock, that determines if we step or not
      assert(dut.io.out.peekInt() == before_step)
      dut.io.signal.poke(true.B)
      dut.clock.step(1)
      assert(dut.io.out.peekInt() != before_step)
      assert(dut.io.out.peekInt() == 1)
      dut.clock.step(test_max_count-1)
      assert(dut.io.out.peekInt() == test_max_count)
      dut.clock.step(1)
      assert(dut.io.out.peekInt() == 0)
      dut.clock.step(test_max_count+1)
      assert(dut.io.out.peekInt() == 0)
    }
  }
}
