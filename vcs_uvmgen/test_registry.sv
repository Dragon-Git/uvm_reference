//
// Template for UVM-compliant Program block
// <PB>        Name of the Program block
// <IF>        Name of Physical interface
// <MOD>       Name of Top-level module 
// <TEST_NAME> Name of the testcase
// <ENV>       Name of environment

`ifndef PB__SV
`define PB__SV
INCL_IFTR_START
`include "IF.sv"  
SING_DRV_START
`include "IF.sv"  
SING_DRV_END
MULT_DRIV_START
`include "IF.sv"  //UVMGEN_RPT_ON_IF
MULT_DRV_END
INCL_IFTR_END

MAST_START
`include "mstr_slv_intfs.incl"
MAST_END
module PB;

import uvm_pkg::*;

`include "ENV.sv"
`include "TEST_NAME.sv"  //ToDo: Change this name to the testcase file-name

// ToDo: Include all other test list here
INCL_IFTR_START
   typedef virtual IF v_if;
   initial begin
      uvm_config_db #(v_if)::set(null,"","mon_if",MOD.mon_if); 
      SING_DRV_START
      uvm_config_db #(v_if)::set(null,"","drv_if",MOD.drv_if);
      SING_DRV_END
      MULT_DRV_START
      uvm_config_db #(virtual IF)::set(null,"","drv_if",MOD.drv_if_RPTNO); //UVMGEN_RPT_ON_IF

      //ToDo: For multi interfaces in single env, user need to create and set other if_ports

      MULT_DRV_END
      run_test();
   end
INCL_IFTR_END
MAST_START
   typedef virtual IF v_if1;
   typedef virtual ISF v_if2;
   initial begin
      uvm_config_db #(v_if1)::set(null,"","mst_if",MOD.mst_if); 
      uvm_config_db #(v_if2)::set(null,"","slv_if",MOD.slv_if);
      run_test();
   end

MAST_END
endmodule: PB

`endif // PB__SV

