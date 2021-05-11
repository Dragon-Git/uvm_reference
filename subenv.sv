//
// Template for UVM-compliant Agent
// <UVM_AGT>    Name of Agent class
// <SEQR>	Name of sequencer
// <XACT> 	Name of Driver
// <MON>	Name of monitor
// <IF>		Name of interface
//

`ifndef AGT__SV
`define AGT__SV

class UVM_AGT extends uvm_agent;
   // ToDo: add sub environmnet properties here
   protected uvm_active_passive_enum is_active = UVM_ACTIVE;
   SEQR sqr;
   XACT drv;
   MON mon;
   IF agt_if;
   typedef virtual IF vif;
NORMAL_START
   `uvm_component_utils(UVM_AGT)
NORMAL_END

MACRO_START
   `uvm_component_utils_begin(UVM_AGT)
   //ToDo: add field utils macros here if required
   `uvm_component_utils_end

      // ToDo: Add required short hand override method
MACRO_END

   function new(string name = "Agent", uvm_component parent = null);
      super.new(name, parent);
   endfunction: new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mon = MON::type_id::create("mon", this);
      if (is_active == UVM_ACTIVE) begin
         sqr = SEQR::type_id::create("sqr", this);
         drv = XACT::type_id::create("drv", this);
      end
      if (!uvm_config_db#(vif)::get(this, "", "if", agt_if)) begin
         `uvm_fatal("AGT/NOVIF", "No virtual interface specified for this agent instance")
      end
      uvm_config_db# (vif)::set(this,"drv","vif",drv.drv_if);
      uvm_config_db# (vif)::set(this,"mon","vif",mon.mon_if);
   endfunction: build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if (is_active == UVM_ACTIVE) begin
         drv.seq_item_port.connect(sqr.seq_item_export);
      end
   endfunction: connect_phase


   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      phase.raise_objection(this,"slv_agt_run");

      //ToDo :: Implement here

      phase.drop_objection(this);
   endtask: run_phase

   virtual function void report_phase(uvm_phase phase);
      super.report_phase(phase);

      //ToDo :: Implement here

   endfunction: report_phase

endclass: UVM_AGT

`endif // AGT__SV
