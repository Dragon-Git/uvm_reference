//
// Template for UVM-compliant Monitor to Coverage Connector Callbacks
//
// <COV>        Name of Coverage Class
// <MON>        Name of Monitor transactor class
// <TR>         Name of transaction descriptor class
// [filename]   MON_2cov_connect

`ifndef MON_2cov_connect
`define MON_2cov_connect
MNTR_OBS_MTHD_ONE_START
class MON_2cov_connect extends MON_callbacks;
MNTR_OBS_MTHD_ONE_END
MNTR_OBS_MTHD_TWO_START
class MON_2cov_connect extends uvm_component;
MNTR_OBS_MTHD_TWO_END
MNTR_OBS_MTHD_ONE_START
   COV cov;

   function new(COV cov);
      this.cov = cov;
   endfunction: new
   // Callback method post_cb_trans can be used for coverage
   virtual task post_cb_trans(MON xactor,
                              TR tr);
      cov.tr = tr;
      -> cov.cov_event;

   endtask: post_cb_trans
MNTR_OBS_MTHD_ONE_END
MNTR_OBS_MTHD_TWO_START
   COV cov;
   uvm_analysis_export # (TR) an_exp;
   `uvm_component_utils(MON_2cov_connect)
   function new(string name="", uvm_component parent=null);
   	super.new(name, parent);
   endfunction: new

   virtual function void write(TR tr);
      cov.tr = tr;
      -> cov.cov_event;
   endfunction:write 
MNTR_OBS_MTHD_TWO_END
endclass: MON_2cov_connect

`endif // MON_2cov_connect
