//
// Template for UVM-compliant physical-level transactor
// <XACT>       Name of transactor
// <IF>         Name of physical interface
// <TR>         Name of input transaction descriptor class
//

`ifndef XACT__SV
`define XACT__SV
INCL_IFTR_START
`include "TR.sv"
INCL_IFTR_END

typedef class TR;
typedef class XACT;

class XACT_callbacks extends uvm_callback;

   // ToDo: Add additional relevant callbacks
   // ToDo: Use "task" if callbacks cannot be blocking

   // Called before a transaction is executed
   virtual task pre_tx( XACT xactor,
                        TR tr);
                                   
     // ToDo: Add relevant code

   endtask: pre_tx


   // Called after a transaction has been executed
   virtual task post_tx( XACT xactor,
                         TR tr);
     // ToDo: Add relevant code

   endtask: post_tx

endclass: XACT_callbacks


UVM_PULL_DRV_START
class XACT extends uvm_driver # (TR);
UVM_PULL_DRV_END
UVM_PUSH_DRV_START
class XACT extends uvm_push_driver # (TR);
UVM_PUSH_DRV_END

   DRIV_TLM_B_TRANS_EX_START
   uvm_tlm_b_transport_export #(TR) drv_b_export;    //Uni directional blocking
   DRIV_TLM_B_TRANS_EX_END
   DRIV_TLM_NB_TRANS_FW_EX_START
   uvm_tlm_nb_transport_fw_export #(TR) drv_nb_export;  //Uni directional non-blocking
   DRIV_TLM_NB_TRANS_FW_EX_END
   
   typedef virtual IF v_if; 
   v_if drv_if;
   NORMAL_START   
   `uvm_component_utils(XACT)
   NORMAL_END 
   `uvm_register_cb(XACT,XACT_callbacks); 
   
   extern function new(string name = "XACT",
                       uvm_component parent = null); 
 
MACRO_START
      `uvm_component_utils_begin(XACT)
      // ToDo: Add uvm driver member
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
   extern protected virtual task send(TR tr); 
   UVM_PUSH_DRV_START
   extern virtual task put(TR item); 
   UVM_PUSH_DRV_END
   extern protected virtual task tx_driver();

endclass: XACT


function XACT::new(string name = "XACT",
                   uvm_component parent = null);
   super.new(name, parent);

   DRIV_TLM_B_TRANS_EX_START
   // drv_b_export = new("Driver blocking export",this);
   // ToDo: Create this port whenever it is needed
   DRIV_TLM_B_TRANS_EX_END
   DRIV_TLM_NB_TRANS_FW_EX_START
   //drv_nb_export = new("Driver non-blocking export",this);
   // ToDo: Create this port whenever it is needed
   DRIV_TLM_NB_TRANS_FW_EX_END
   
endfunction: new


function void XACT::build_phase(uvm_phase phase);
   super.build_phase(phase);
   //ToDo : Implement this phase here

endfunction: build_phase

function void XACT::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   INCL_IFTR_START
   uvm_config_db#(v_if)::get(this, "", "drv_if", drv_if);
   INCL_IFTR_END
   MST_CODE_EN_START
   uvm_config_db#(v_if)::get(this, "", "mst_if", drv_if);
   MST_CODE_EN_END
   SLV_CODE_EN_START
   uvm_config_db#(v_if)::get(this, "", "slv_if", drv_if);
   SLV_CODE_EN_END
endfunction: connect_phase

function void XACT::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase);
   if (drv_if == null)
       `uvm_fatal("NO_CONN", "Virtual port not connected to the actual interface instance");   
endfunction: end_of_elaboration_phase

function void XACT::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here
endfunction: start_of_simulation_phase

 
task XACT::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   phase.raise_objection(this,"");
   // ToDo: Reset output signals
   phase.drop_objection(this);
endtask: reset_phase

task XACT::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   phase.raise_objection(this,"");
   //ToDo: Configure your component here
   phase.drop_objection(this);
endtask:configure_phase


task XACT::run_phase(uvm_phase phase);
   super.run_phase(phase);
   phase.raise_objection(this,"");
   fork 
      tx_driver();
   join
   phase.drop_objection(this);
endtask: run_phase


task XACT::tx_driver();
      UVM_PULL_DRV_START
 forever begin
      TR tr;
      // ToDo: Set output signals to their idle state
      this.drv_if.master.async_en      <= 0;
      `uvm_info("TX_DRIVER", "Starting transaction...",UVM_LOW)
      seq_item_port.get_next_item(tr);
      case (tr.kind) 
         TR::READ: begin
            // ToDo: Implement READ transaction

         end
         TR::WRITE: begin
            // ToDo: Implement READ transaction

         end
      endcase
	  `uvm_do_callbacks(XACT,XACT_callbacks,
                    pre_tx(this, tr))
      send(tr); 
      seq_item_port.item_done();
      `uvm_info("TX_DRIVER", "Completed transaction...",UVM_LOW)
      `uvm_info("TX_DRIVER", tr.sprint(),UVM_HIGH)
      `uvm_do_callbacks(XACT,XACT_callbacks,
                    post_tx(this, tr))

   end
      UVM_PULL_DRV_END
endtask : tx_driver

task XACT::send(TR tr);
   // ToDo: Drive signal on interface
  
endtask: send

UVM_PUSH_DRV_START
task XACT::put(TR item);
   case (item.kind)
   TR::READ: begin
     // ToDo: Implement READ transaction
     end
   TR::WRITE: begin
     // ToDo: Implement READ transaction
     end
   endcase
   send(item);
endtask : put
UVM_PUSH_DRV_END

`endif // XACT__SV


