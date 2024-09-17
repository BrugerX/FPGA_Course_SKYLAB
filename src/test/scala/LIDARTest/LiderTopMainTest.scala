import LIDAR.LidarTopMain
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec


class LidarTopMainTest extends AnyFlatSpec with ChiselScalatestTester {
  "FullTestTop" should "pass" in {
    test(new LidarTopMain()).withAnnotations(Seq(WriteVcdAnnotation))
    { dut =>
      dut.clock.setTimeout(0)
      dut.clock.step(150000)
    }
  }
}
