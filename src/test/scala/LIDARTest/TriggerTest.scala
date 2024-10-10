import LIDAR.Trigger
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec



class triggerTest extends AnyFlatSpec with ChiselScalatestTester {
  "triggerTest" should "pass" in {
    test(new Trigger()).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.start_trigger.poke(true.B)
      dut.clock.step(1)
      dut.io.start_trigger.poke(false.B)
      dut.clock.step(12)

      dut.io.start_trigger.poke(true.B)
      dut.clock.step(3)
      dut.io.start_trigger.poke(false.B)
      dut.clock.step(9)

      dut.io.start_trigger.poke(true.B)
      dut.clock.step(3)
      dut.io.start_trigger.poke(false.B)
      dut.clock.step(1)
      dut.io.start_trigger.poke(true.B)
      dut.clock.step(1)
      dut.io.start_trigger.poke(false.B)
      dut.clock.step(3)

      dut.io.start_trigger.poke(true.B)
      dut.clock.step(12)

    }
  }
}
