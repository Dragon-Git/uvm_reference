//
// Template for UVM-compliant generic master agent
// <MAST_AGT>   Name of the master agent
// <SEQR>       Name of sequencer
// <XACT>       Name of driver
// <MON>        Name of monitor
// <IF>         Name of the interface
//

`ifndef MAST_AGT__SV
`define MAST_AGT__SV


class MAST_AGT extends uvm_agent;
   // ToDo: add uvm agent properties here
   protected uvm_active_passive_enum is_active = UVM_ACTIVE;
   SEQR mast_sqr;
   XACT mast_drv;
   MON mast_mon;
   typedef virtual IF vif;
   vif mast_agt_if; 
NORMAL_START
   `uvm_component_utils(MAST_AGT)
NORMAL_END

MACRO_START
   `uvm_component_utils_begin(MAST_AGT)
   //ToDo: add field utils macros here if required
	`uvm_component_utils_end

      // ToDo: Add required short hand override method
MACRO_END

   function new(string name = "mast_agt", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      mast_mon = MON::type_id::create("mast_mon", this);
      if (is_active == UVM_ACTIVE) begin
         mast_sqr = SEQR::type_id::create("mast_sqr", this);
         mast_drv = XACT::type_id::create("mast_drv", this);
      end
      if (!uvm_config_db#(vif)::get(this, "", "mst_if", mast_agt_if)) begin
         `uvm_fatal("AGT/NOVIF", "No virtual interface specified for this agent instance")
      end
      uvm_config_db# (vif)::set(this,"mast_drv","mst_if",mast_drv.drv_if);
      uvm_config_db# (vif)::set(this,"mast_mon","mst_if",mast_mon.mon_if);
   endfunction: build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if (is_active == UVM_ACTIVE) begin
		  UVM_PULL_DRV_START
   		  mast_drv.seq_item_port.connect(mast_sqr.seq_item_export);
    	  UVM_PULL_DRV_END
      	  UVM_PUSH_DRV_START
   		  mast_sqr.req_port.connect(mast_drv.req_export);
   		  UVM_PUSH_DRV_END
      end
   endfunction

   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      phase.raise_objection(this,"slv_agt_run");

      //ToDo :: Implement here

      phase.drop_objection(this);
   endtask

   virtual function void report_phase(uvm_phase phase);
      super.report_phase(phase);

      //ToDo :: Implement here

   endfunction

endclass: MAST_AGT
 
`endif // MAST_AGT__SV

