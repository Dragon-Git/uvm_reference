//
// Template for UVM Scoreboard
// <SB>         Name of Scoreboard Class
// <TR>         Name of Transaction Descriptor

`ifndef SB__SV
`define SB__SV

DIFF_ACT_START
   `uvm_analysis_imp_decl(_ingress)
   `uvm_analysis_imp_decl(_egress) 
DIFF_ACT_END   	 

class SB extends uvm_scoreboard;

   SAME_ACT_START
   uvm_analysis_export #(TR) before_export, after_export;
   uvm_in_order_class_comparator #(TR) comparator;
   SAME_ACT_END
   DIFF_ACT_START 
   uvm_analysis_imp_ingress #(MAST_TACTION,SB) before_export;
   uvm_analysis_imp_egress #(SLV_TACTION,SB) after_export;
   // Built in UVM comparator will not be used. User has to define the compare logic
   DIFF_ACT_END

   `uvm_component_utils(SB)
	extern function new(string name = "SB",
                    uvm_component parent = null); 
	extern virtual function void build_phase (uvm_phase phase);
	extern virtual function void connect_phase (uvm_phase phase);
	extern virtual task main_phase(uvm_phase phase);
	extern virtual function void report_phase(uvm_phase phase);
 DIFF_ACT_START
 	extern function void write_ingress(MAST_TACTION tr);
	extern function void write_egress(SLV_TACTION tr);
 DIFF_ACT_END

endclass: SB


function SB::new(string name = "SB",
                 uvm_component parent);
   super.new(name,parent);
endfunction: new

function void SB::build_phase(uvm_phase phase);
    super.build_phase(phase);
    before_export = new("before_export", this);
    after_export  = new("after_export", this);
	SAME_ACT_START
    comparator    = new("comparator", this);
	SAME_ACT_END
endfunction:build_phase

function void SB::connect_phase(uvm_phase phase);
    SAME_ACT_START
    before_export.connect(comparator.before_export);
    after_export.connect(comparator.after_export);
	SAME_ACT_END
endfunction:connect_phase

task SB::main_phase(uvm_phase phase);
    super.main_phase(phase);
    phase.raise_objection(this,"scbd..");
	SAME_ACT_START
	comparator.run();
	SAME_ACT_END
    phase.drop_objection(this);
endtask: main_phase 

function void SB::report_phase(uvm_phase phase);
    super.report_phase(phase);
	SAME_ACT_START
    `uvm_info("SBRPT", $psprintf("Matches = %0d, Mismatches = %0d",
               comparator.m_matches, comparator.m_mismatches),
               UVM_MEDIUM);
	SAME_ACT_END
endfunction:report_phase

DIFF_ACT_START
function void SB::write_ingress(MAST_TACTION tr);
// User needs to add functionality here 
endfunction

function  void SB::write_egress(SLV_TACTION tr);
endfunction
DIFF_ACT_END
`endif // SB__SV
