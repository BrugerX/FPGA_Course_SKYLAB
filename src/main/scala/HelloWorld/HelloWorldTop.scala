package HelloWorld

import Hello.Hello
import chisel3._


class HelloWorldTop extends Module {
  val io =
    IO(new Bundle {

  })

  var hello_timer = Module(new Hello)


}
