import LIDAR.DistanceCalculator
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class DistanceCalculatorTest extends AnyFlatSpec with ChiselScalatestTester {
  "DistanceCalculator" should "pass" in {
    test(new DistanceCalculator())
    { dut =>
      //To begin with we get 0
      assert(0 == dut.io.distance_cm.peekInt())
      dut.io.clock_cycles.poke(1000.U)
      //We shouldn't have to wait a clock cycle to get 1700000 (* 10^-6) cm
      // As we're dealing with a combinatorial circuit

      assert(dut.io.distance_cm.peekInt() == 1700000)
      dut.clock.step(1)

      //It should remain so even after the current clock cycle ends
      assert(dut.io.distance_cm.peekInt() == 1700000)

      //
      dut.io.clock_cycles.poke(393939.U)
      assert(dut.io.distance_cm.peekInt() == 669696300)

    }
  }
}