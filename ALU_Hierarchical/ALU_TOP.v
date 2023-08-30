//Top module name
module ALU_TOP
#(parameter in_width = 8, out_width = 16)
( 
  //ALU parameterized Operands
  input [in_width-1 :0] A, B,
  //ALU function selection
  input [3:0] ALU_FUN,
  input CLK, RST,
  //ALU parameterized outputs
  output [out_width-1 :0] Arith_OUT, Logic_OUT, CMP_OUT, SHIFT_OUT,
  //ALU output flags
  output Carry_OUT, Arith_Flag, Logic_Flag, CMP_Flag, SHIFT_Flag
);
  
  //ALU internal wires between decoder and each block
  wire Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable;
  
  //ARITHMETIC_UNIT instantiation
  ARITHMETIC_UNIT Arith(
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .Arith_Enable(Arith_Enable),
  .clk(CLK),
  .RST(RST),
  .Arith_OUT(Arith_OUT),
  .Carry_OUT(Carry_OUT),
  .Arith_Flag(Arith_Flag)
  );
  
  //LOGIC_UNIT instantiation
  LOGIC_UNIT Logic(
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .Logic_Enable(Logic_Enable),
  .clk(CLK),
  .RST(RST),
  .Logic_OUT(Logic_OUT),
  .Logic_Flag(Logic_Flag)
  );
  
  //CMP_UNIT instantiation
  CMP_UNIT CMP(
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .CMP_Enable(CMP_Enable),
  .clk(CLK),
  .RST(RST),
  .CMP_OUT(CMP_OUT),
  .CMP_Flag(CMP_Flag)
  );
  
  //SHIFT_UNIT instantiation
  SHIFT_UNIT Shift(
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN[1:0]),
  .Shift_Enable(Shift_Enable),
  .clk(CLK),
  .RST(RST),
  .SHIFT_OUT(SHIFT_OUT),
  .SHIFT_Flag(SHIFT_Flag)
  );  
  
  //Decoder_2x4 instantiation
  Decoder_2x4 decoder(
  .ALU_FUN(ALU_FUN[3:2]),
  .y({Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable})
  );
  
endmodule