package LIDAR
import chisel3._

class LidarTopMain extends Module {
  val io = IO(new Bundle {
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))

    //Measured distance in CM
    val sensor_measurement = Output(UInt(8.W))
    val sensor_measurement2 = Output(UInt(8.W))

    //To send trigger signal
    val sensor_trigger_pin = Output(Bool())

    //For testing
    val physical_echo_test = Input(Bool())
    val physical_echo_test2 = Input(Bool())
  })


  val sensor = Module(new HCSR04Sensor())
  val sensor2 = Module(new HCSR04Sensor())

  val regCount = RegInit(0.U(32.W))

  sensor.io.physical_echo_test := io.physical_echo_test
  io.sensor_trigger_pin := ~sensor.io.sensor_trigger_pin
  io.sensor_measurement := sensor.io.sensor_measurement

  io.sensor_measurement2 := sensor2.io.sensor_measurement

  sensor2.io.physical_echo_test := io.physical_echo_test2

  //Weirds names are a result of being copied from different project
  val display = Module(new Display())
  io.seg := display.io.seg
  io.an := display.io.an

  display.io.sum := sensor2.io.sensor_measurement
  display.io.price := sensor.io.sensor_measurement

  //1Hz refresh clock
  sensor.io.start_reading := false.B
  sensor2.io.start_reading := false.B
  regCount := regCount + 1.U
  when(regCount === 100000000.U) {
    sensor2.io.start_reading := true.B
    sensor.io.start_reading := true.B
    regCount := 0.U
  }
}

object LidarTopMainBuild extends App {
  emitVerilog(new LidarTopMain)
}

