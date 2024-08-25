import LIDAR.HCSR04Sensor
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class HCSR04SensorTest extends AnyFlatSpec with ChiselScalatestTester {
  "HCSR04" should "pass" in {
    test(new HCSR04Sensor())
    { dut =>
      dut.io.start_reading.poke(true)
      assert(dut.io.dist_cm.peekInt() == 0)
      print("Sig counter: " + dut.io.sig_counter.peekInt() + "\n")
      dut.clock.step(1)
      dut.io.start_reading.poke(true)
      //100 CCs have now passed
      dut.clock.step(200)
      dut.io.physical_echo_test.poke(true)
      print(dut.io.dist_cm.peekInt() + "\n")
      print("Sig counter: " + dut.io.sig_counter.peekInt() + "\n")
      dut.clock.step(1)

      print(dut.io.dist_cm.peekInt())
      dut.clock.step(1)
    }
  }
}
