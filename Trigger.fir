circuit Trigger :
  module Trigger :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip start_trigger : UInt<1>, trigger_out : UInt<1>}

    reg count_reg : UInt<10>, clock with :
      reset => (reset, UInt<10>("h0")) @[Trigger.scala 13:26]
    reg risingEdge_REG : UInt<1>, clock with :
      reset => (UInt<1>("h0"), risingEdge_REG) @[Trigger.scala 15:47]
    risingEdge_REG <= io.start_trigger @[Trigger.scala 15:47]
    node _risingEdge_T = eq(risingEdge_REG, UInt<1>("h0")) @[Trigger.scala 15:39]
    node risingEdge = and(io.start_trigger, _risingEdge_T) @[Trigger.scala 15:37]
    reg stateReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Trigger.scala 21:25]
    io.trigger_out <= UInt<1>("h0") @[Trigger.scala 22:18]
    node _T = asUInt(UInt<1>("h0")) @[Trigger.scala 24:20]
    node _T_1 = asUInt(stateReg) @[Trigger.scala 24:20]
    node _T_2 = eq(_T, _T_1) @[Trigger.scala 24:20]
    when _T_2 : @[Trigger.scala 24:20]
      count_reg <= UInt<1>("h0") @[Trigger.scala 26:17]
      node _T_3 = eq(risingEdge, UInt<1>("h1")) @[Trigger.scala 27:23]
      when _T_3 : @[Trigger.scala 27:35]
        stateReg <= UInt<1>("h1") @[Trigger.scala 28:18]
    else :
      node _T_4 = asUInt(UInt<1>("h1")) @[Trigger.scala 24:20]
      node _T_5 = asUInt(stateReg) @[Trigger.scala 24:20]
      node _T_6 = eq(_T_4, _T_5) @[Trigger.scala 24:20]
      when _T_6 : @[Trigger.scala 24:20]
        node _count_reg_T = add(count_reg, UInt<1>("h1")) @[Trigger.scala 33:30]
        node _count_reg_T_1 = tail(_count_reg_T, 1) @[Trigger.scala 33:30]
        count_reg <= _count_reg_T_1 @[Trigger.scala 33:17]
        io.trigger_out <= UInt<1>("h1") @[Trigger.scala 34:22]
        node _T_7 = eq(count_reg, UInt<3>("h5")) @[Trigger.scala 35:23]
        when _T_7 : @[Trigger.scala 35:33]
          stateReg <= UInt<1>("h0") @[Trigger.scala 36:18]


