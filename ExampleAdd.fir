circuit ExampleAdd :
  module ExampleAdd :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip num1 : UInt<8>, flip num2 : UInt<8>, res : UInt<9>, overFlow : UInt<1>}

    node _io_res_T = add(io.num1, io.num2) @[ExampleAdd.scala 13:21]
    node _io_res_T_1 = tail(_io_res_T, 1) @[ExampleAdd.scala 13:21]
    io.res <= _io_res_T_1 @[ExampleAdd.scala 13:10]
    node _io_overFlow_T = gt(io.res, UInt<8>("hff")) @[ExampleAdd.scala 14:25]
    io.overFlow <= _io_overFlow_T @[ExampleAdd.scala 14:15]

