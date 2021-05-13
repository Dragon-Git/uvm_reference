//
// Template for UVM-compliant generic slave agent component
// <REC>       Name of generic slave agent
// <MON>       Name of monitor
// <IF>        Name of physical interface
// <TR>        Name of input/output transaction descriptor class
// <XACT>      Name of the driver
// <SEQR>      Name of the sequencer
//

`ifndef REC__SV
`define REC__SV


class REC extends uvm_agent;
   // ToDo: add sub environment properties here
   protected uvm_active_passive_enum is_active = UVM_ACTIVE;
   XACT slv_drv;
   MON slv_mon;
   SEQR slv_seqr;
   typedef virtual IF vif;
   vif slv_agt_if;
NORMAL_START
   `uvm_component_utils(REC)
NORMAL_END

MACRO_START
   `uvm_component_utils_begin(REC)
    //ToDo: add field utils macros here if required
   `uvm_component_utils_end

      // ToDo: Add required short hand override method
MACRO_END

   function new(string name = "slv_agt", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      slv_mon = MON::type_id::create("mon", this);
      if (is_active == UVM_ACTIVE) begin
         slv_drv = XACT::type_id::create("drv", this);
         slv_seqr = SEQR::type_id::create("slv_seqr",this);
      end
      if (!uvm_config_db#(vif)::get(this, "", "slv_if", slv_agt_if)) begin
         `uvm_fatal("AGT/NOVIF", "No virtual interface specified for this agent instance")
      end
      uvm_config_db# (vif)::set(this,"slv_drv","slv_if",slv_drv.drv_if);
      uvm_config_db# (vif)::set(this,"mast_mon","slv_if",slv_mon.mon_if);
   endfunction: build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if (is_active == UVM_ACTIVE) begin
		  
   		  UVM_PULL_DRV_START
	   	  slv_drv.seq_item_port.connect(slv_seqr.seq_item_export);
		  UVM_PULL_DRV_END
		  UVM_PUSH_DRV_START
   		  slv_seqr.req_port.connect(slv_drv.req_export);
		  UVM_PUSH_DRV_END		  
      end
   endfunction

   virtual function void start_of_simulation_phase(uvm_phase phase);
      super.start_of_simulation_phase(phase);

      //ToDo :: Implement here

   endfunction

   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      phase.raise_objection(this,"slv_agt_main");

      //ToDo :: Implement here

      phase.drop_objection(this);
   endtask

   virtual function void report_phase(uvm_phase phase);
      super.report_phase(phase);

      //ToDo :: Implement here

   endfunction

endclass: REC

`endif // REC__SV
