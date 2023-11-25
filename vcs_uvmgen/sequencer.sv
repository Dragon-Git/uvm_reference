//
// Template for UVM-compliant sequencer class
//
//<SEQR>   Name of sequencer class
//<TR>   Name of transaction description class
// [filename]   SEQR


`ifndef SEQR__SV
`define SEQR__SV


typedef class TR;
UVM_PULL_DRV_START
class SEQR extends uvm_sequencer # (TR);
UVM_PULL_DRV_END
UVM_PUSH_DRV_START
class SEQR extends uvm_push_sequencer # (TR);
UVM_PUSH_DRV_END

   `uvm_component_utils(SEQR)
   function new (string name,
                 uvm_component parent);
   super.new(name,parent);
   endfunction:new 
endclass:SEQR

`endif // SEQR__SV
