//
// Template for Top module
// <MOD>        Name of top module
// <IF>         Name of physical interface
// <PB>         Name of the testbench module
//

`ifndef MOD__SV
`define MOD__SV

module MOD();

   logic clk;
   logic rst;

   // Clock Generation
   parameter sim_cycle = 10;
   
   // Reset Delay Parameter
   parameter rst_delay = 50;

   always 
      begin
         clk = #(sim_cycle/2) ~clk;
      end
INCL_IFTR_START
   IF mon_if(clk,rst);
   SING_DRV_START
   IF drv_if(clk,rst);
   SING_DRV_END
   MULT_DRV_START
   IF drv_if_RPTNO (clk,rst);    //UVMGEN_RPT_ON_IF
   MULT_DRV_END
INCL_IFTR_END

MAST_START
   IF mst_if(clk,rst);
   ISF slv_if(clk,rst);
MAST_END
   
   PB test(); 
   
   // ToDo: Include Dut instance here
  
   //Driver reset depending on rst_delay
   initial
      begin
         clk = 0;
         rst = 0;
      #1 rst = 1;
         repeat (rst_delay) @(clk);
         rst = 1'b0;
         @(clk);
   end

endmodule: MOD

`endif // MOD__SV
