import LIDAR.HCSR04Sensor
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class HCSR04SensorTest extends AnyFlatSpec with ChiselScalatestTester {
  "HCSR04" should "pass" in {
    test(new HCSR04Sensor())
    { dut =>
      assert(dut.io.sensor_measurement.peekInt() == 0)
      dut.io.start_reading.poke(true)
      dut.clock.step(1)
      dut.io.start_reading.poke(false)
      //We get echo before a clock cycle passes
      dut.io.physical_echo_test.poke(true)
      dut.clock.step(1)
      assert(dut.io.sensor_measurement.peekInt() == 0)
      dut.clock.step(1)
      assert(dut.io.sensor_measurement.peekInt() == 1700)
      dut.io.start_reading.poke(true)
      dut.io.physical_echo_test.poke(false)
      dut.clock.step(1)
      print("Measurement: " + dut.io.sensor_measurement.peekInt() + "\n")
      dut.io.start_reading.poke(false)
      dut.clock.step(99)
      dut.io.physical_echo_test.poke(true)
      dut.clock.step(1)
      print("Measurement: " + dut.io.sensor_measurement.peekInt() + "\n")
    }
  }
}
