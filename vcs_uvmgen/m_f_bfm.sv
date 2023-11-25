//
// Template for UVM-compliant physical-level monitor
// <MON>        Name of monitor transactor
// <IF>         Name of physical interface
// <TR>         Name of output transaction descriptor class
//

`ifndef MON__SV
`define MON__SV

INCL_IFTR_START
//`include "IF.sv"
`include "TR.sv"
INCL_IFTR_END

typedef class TR;
typedef class MON;

class MON_callbacks extends uvm_callback;

   // ToDo: Add additional relevant callbacks
   // ToDo: Use a task if callbacks can be blocking


   // Called at start of observed transaction
   virtual function void pre_trans(MON xactor,
                                   TR tr);
   endfunction: pre_trans


   // Called before acknowledging a transaction
   virtual function pre_ack(MON xactor,
                            TR tr);
   endfunction: pre_ack
   

   // Called at end of observed transaction
   virtual function void post_trans(MON xactor,
                                    TR tr);
   endfunction: post_trans

   
   // Callback method post_cb_trans can be used for coverage
   virtual task post_cb_trans(MON xactor,
                              TR tr);
   endtask: post_cb_trans

endclass: MON_callbacks

   

class MON extends uvm_monitor;

   MNTR_OBS_MTHD_TWO_START
   uvm_analysis_port #(TR) mon_analysis_port;  //TLM analysis port
   MNTR_OBS_MTHD_TWO_END
   typedef virtual IF v_if;
   v_if mon_if;
   // ToDo: Add another class property if required
   extern function new(string name = "MON",uvm_component parent);
   `uvm_register_cb(MON,MON_callbacks);
   NORMAL_START
   `uvm_component_utils(MON)
   NORMAL_END                  
   MACRO_START
   `uvm_component_utils_begin(MON)
      // ToDo: Add uvm monitor member if any class property added later through field macros

   `uvm_component_utils_end
      // ToDo: Add required short hand override method

   MACRO_END

   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern protected virtual task tx_monitor();

endclass: MON


function MON::new(string name = "MON",uvm_component parent);
   super.new(name, parent);
   MNTR_OBS_MTHD_TWO_START
   mon_analysis_port = new ("mon_analysis_port",this);
   MNTR_OBS_MTHD_TWO_END
endfunction: new

function void MON::build_phase(uvm_phase phase);
   super.build_phase(phase);
   //ToDo : Implement this phase here

endfunction: build_phase

function void MON::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   uvm_config_db#(v_if)::get(this, "", "mon_if", mon_if);
endfunction: connect_phase

function void MON::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase); 
   //ToDo: Implement this phase here

endfunction: end_of_elaboration_phase


function void MON::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here

endfunction: start_of_simulation_phase


task MON::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   phase.raise_objection(this,"");
   // ToDo: Implement reset here
   phase.drop_objection(this);

endtask: reset_phase


task MON::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   phase.raise_objection(this,"");
   //ToDo: Configure your component here
   phase.drop_objection(this);

endtask:configure_phase


task MON::run_phase(uvm_phase phase);
   super.run_phase(phase);
   phase.raise_objection(this,"");
   fork
      tx_monitor();
   join
   phase.drop_objection(this);

endtask: run_phase


task MON::tx_monitor();
   forever begin
      TR tr;
      // ToDo: Wait for start of transaction

      `uvm_do_callbacks(MON,MON_callbacks,
                    pre_trans(this, tr))
      `uvm_info("TX_MONITOR", "Starting transaction...",UVM_LOW)
      // ToDo: Observe first half of transaction

      // ToDo: User need to add monitoring logic and remove $finish
      `uvm_info("TX_MONITOR"," User need to add monitoring logic ",UVM_LOW)
	  $finish;
      `uvm_do_callbacks(MON,MON_callbacks,
                    pre_ack(this, tr))
      // ToDo: React to observed transaction with ACK/NAK
      `uvm_info("TX_MONITOR", "Completed transaction...",UVM_HIGH)
      `uvm_info("TX_MONITOR", tr.sprint(),UVM_HIGH)
      `uvm_do_callbacks(MON,MON_callbacks,
                    post_trans(this, tr))
      MNTR_OBS_MTHD_TWO_START
      mon_analysis_port.write(tr);
      MNTR_OBS_MTHD_TWO_END 
   end
endtask: tx_monitor

`endif // MON__SV
