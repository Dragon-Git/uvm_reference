//
// Template for UVM-compliant verification environment
// <ENV>       Name of Environment class
// <MAST_AGT>  Name of master agent
// <REC> 	   Name of slave agent
// <SB>        Name of Scoreboard class
// <COV>       Name of the coverage class
// <REGTR>     Name of the RAL adapter
// [filename]  ENV
//

`ifndef ENV__SV
`define ENV__SV
`include "VNAME.sv"
//ToDo: Include required files here
RAL_START
class reg_seq extends uvm_reg_sequence;
   ral_block_VNAME regmodel;

   `uvm_object_utils(reg_seq)

   function new(string name = "");
      super.new(name);
   endfunction:new

   task pre_body();
      $cast(regmodel,model);
   endtask

   task body;
      uvm_status_e status;
      uvm_reg_data_t data;
   //ToDo :Define the user sequence here
   endtask
endclass
RAL_END
//Including all the required component files here
class ENV extends uvm_env;
   SCBD_EN_START 
   SB sb;
   SCBD_EN_END
   RAL_START  
   ral_block_VNAME regmodel;
   reg_seq ral_sequence; 
   RAL_END
   MAST_AGT master_agent;
   REC slave_agent;
   COV cov;
   
   RAL_START
   SING_DM_START
   REGTR reg2host;
   SING_DM_END
   MULT_DM_START
   REGTR reg2host;
   REGTR1 reg2host1;
   MULT_DM_END
   RAL_END
   MNTR_OBS_MTHD_ONE_START 
   MON_2cov_connect mon2cov;
   MNTR_OBS_MTHD_ONE_END
   MNTR_OBS_MTHD_TWO_START 
   MNTR_OBS_MTHD_TWO_Q_START
   MON_2cov_connect mon2cov;
   MNTR_OBS_MTHD_TWO_Q_END
   MNTR_OBS_MTHD_TWO_END


    `uvm_component_utils(ENV)

   extern function new(string name="ENV", uvm_component parent=null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern function void start_of_simulation_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern virtual task shutdown_phase(uvm_phase phase);

endclass: ENV

function ENV::new(string name= "ENV",uvm_component parent=null);
   super.new(name,parent);
endfunction:new

function void ENV::build_phase(uvm_phase phase);
   super.build_phase(phase);
   master_agent = MAST_AGT::type_id::create("master_agent",this); 
   slave_agent = REC::type_id::create("slave_agent",this);
 
   //ToDo: Register other components,callbacks and TLM ports if added by user  

   cov = COV::type_id::create("cov",this); //Instantiating the coverage class

   MNTR_OBS_MTHD_ONE_START
   mon2cov  = new(cov);
   uvm_callbacks # (MON,MON_callbacks)::add(slave_agent.slv_mon,mon2cov);
   MNTR_OBS_MTHD_ONE_END
   MNTR_OBS_MTHD_TWO_START
   mon2cov  = MON_2cov_connect::type_id::create("mon2cov", this);
   mon2cov.cov = cov;
   MNTR_OBS_MTHD_TWO_END
   SCBD_EN_START
   sb = SB::type_id::create("sb",this);
   SCBD_EN_END
   RAL_START
   
   this.regmodel = ral_block_VNAME::type_id::create("regmodel",this);
   regmodel.build();
   ral_sequence = reg_seq::type_id::create("ral_sequence");
   ral_sequence.model = regmodel; 
   SING_DM_START
   reg2host = new("reg2host");
   SING_DM_END
   MULT_DM_START
   reg2host = new("reg2host");
   reg2host1 = new("reg2host1");
   MULT_DM_END
   RAL_END 
   // ToDo: To enable backdoor access specify the HDL path
   // ToDo: Register any required callbacks
   RAL_END
endfunction: build_phase

function void ENV::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   MNTR_OBS_MTHD_TWO_START
   MNTR_OBS_MTHD_TWO_NQ_START
   SCBD_EN_START
   //Connecting the monitor's analysis ports with SB's expected analysis exports.
   master_agent.mast_mon.mon_analysis_port.connect(sb.before_export);
   slave_agent.slv_mon.mon_analysis_port.connect(sb.after_export);
   //Other monitor element will be connected to the after export of the scoreboard
   SCBD_EN_END
   MNTR_OBS_MTHD_TWO_NQ_END
   MNTR_OBS_MTHD_TWO_END 
   RAL_START
   regmodel.default_map.set_sequencer(master_agent.mast_sqr,reg2host);
   RAL_END 
   master_agent.mast_mon.mon_analysis_port.connect(cov.cov_export);
endfunction: connect_phase

function void ENV::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo : Implement this phase here 
endfunction: start_of_simulation_phase


task ENV::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   phase.raise_objection(this,"Resetting the DUT...");
   //ToDo: Reset DUT
   phase.drop_objection(this);
endtask:reset_phase

task ENV::configure_phase (uvm_phase phase);
   super.configure_phase(phase);
   phase.raise_objection(this,"");
   //ToDo: Configure components here
   phase.drop_objection(this);
endtask:configure_phase

task ENV::run_phase(uvm_phase phase);
   super.run_phase(phase);
   phase.raise_objection(this,"");
   //ToDo: Run your simulation here
   phase.drop_objection(this);
endtask:run_phase

function void ENV::report_phase(uvm_phase phase);
   super.report_phase(phase);
   //ToDo: Implement this phase here
endfunction:report_phase

task ENV::shutdown_phase(uvm_phase phase);
   super.shutdown_phase(phase);
   //ToDo: Implement this phase here
endtask:shutdown_phase
`endif // ENV__SV

