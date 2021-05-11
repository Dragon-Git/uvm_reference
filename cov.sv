//
// Template for UVM-compliant Coverage Class
// <COV>        Name of Coverage class
// <TR>         Name of Transaction descriptor class
//

`ifndef COV__SV
`define COV__SV

class COV extends uvm_component;
   event cov_event;
   TR tr;
   MNTR_OBS_MTHD_TWO_START
   uvm_analysis_imp #(TR, COV) cov_export;
   MNTR_OBS_MTHD_TWO_END
   `uvm_component_utils(COV)
 
   covergroup cg_trans @(cov_event);
      coverpoint tr.kind;
      // ToDo: Add required coverpoints, coverbins
   endgroup: cg_trans


   function new(string name, uvm_component parent);
      super.new(name,parent);
      cg_trans = new;
      MNTR_OBS_MTHD_TWO_START
      cov_export = new("Coverage Analysis",this);
      MNTR_OBS_MTHD_TWO_END
   endfunction: new
   MNTR_OBS_MTHD_TWO_START 

   virtual function write(TR tr);
      this.tr = tr;
      -> cov_event;
   endfunction: write
   MNTR_OBS_MTHD_TWO_END

endclass: COV

`endif // COV__SV

