import HelloWorld.ExampleAdd
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ExampleTest extends AnyFlatSpec with ChiselScalatestTester {
  "exampleTest" should "pass" in {
    test(new ExampleAdd()).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      dut.io.num1.poke(5.U)
      dut.io.num2.poke(0.U)
      dut.clock.step(2)

      dut.io.num1.poke(5.U)
      dut.io.num2.poke(3.U)
      dut.clock.step(2)

      dut.io.num1.poke(200.U)
      dut.io.num2.poke(200.U)
      dut.clock.step(2)
    }
  }
}

