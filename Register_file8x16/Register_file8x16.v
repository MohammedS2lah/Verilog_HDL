//Module name of 8 x 16 Register File
module Register_file8x16(

  //Write data bus(WrData)
  input [15:0] WrData,
  //Address bus (Address) used for both read and write operations.
  input [2:0] Address,
  //Write operation signal
  input WrEn,
  //Read operation signal
  input RdEn,
  input CLK,
  //Asynchronous active low Reset
  input RST,
  //Read data bus(RdData)
  output reg [15:0] RdData
);

  // 2D Array Reg_File consists of 8 registers, each register of 16-bit width
  reg [15:0] Reg_File [0:7];
  
  //RTL code
  always@(posedge CLK, negedge RST)
  begin
    if(!RST)
      begin
        Reg_File[0] <= 16'b0;
        Reg_File[1] <= 16'b0;
        Reg_File[2] <= 16'b0;
        Reg_File[3] <= 16'b0;
        Reg_File[4] <= 16'b0;
        Reg_File[5] <= 16'b0;
        Reg_File[6] <= 16'b0;
        Reg_File[7] <= 16'b0;
        RdData <= 'b0;
      end
    else if(WrEn & !RdEn)
      begin
        RdData <= 'b0;
        case(Address)
          0: Reg_File[0] <= WrData;
          1: Reg_File[1] <= WrData;
          2: Reg_File[2] <= WrData;
          3: Reg_File[3] <= WrData;
          4: Reg_File[4] <= WrData;
          5: Reg_File[5] <= WrData;
          6: Reg_File[6] <= WrData;
          7: Reg_File[7] <= WrData;
          default: Reg_File[0] <= WrData;
        endcase
      end 
    else if(RdEn & !WrEn)
      begin
        case(Address)
          0: RdData <= Reg_File[0];
          1: RdData <= Reg_File[1];
          2: RdData <= Reg_File[2];
          3: RdData <= Reg_File[3];
          4: RdData <= Reg_File[4];
          5: RdData <= Reg_File[5];
          6: RdData <= Reg_File[6];
          7: RdData <= Reg_File[7];
          default: RdData <= Reg_File[0];
        endcase
      end
    else begin
      $display("Error: Choose only one operation");  
        RdData <= 'hFFFF;
    end
  end

endmodule