module ExampleAdd(
  input        clock,
  input        reset,
  input  [7:0] io_num1,
  input  [7:0] io_num2,
  output [8:0] io_res,
  output       io_overFlow
);
  wire [7:0] _io_res_T_1 = io_num1 + io_num2; // @[ExampleAdd.scala 13:21]
  assign io_res = {{1'd0}, _io_res_T_1}; // @[ExampleAdd.scala 13:10]
  assign io_overFlow = io_res > 9'hff; // @[ExampleAdd.scala 14:25]
endmodule
