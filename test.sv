//
// Template for UVM-compliant testcase
// <TEST_NAME>  Name of test case
// <ENV>        Name of env class 
// <SCEN>       Name of sequence library
// [filename]   TEST_NAME

`ifndef TEST__SV
`define TEST__SV

typedef class ENV;

class TEST_NAME extends uvm_test;

  `uvm_component_utils(TEST_NAME)

  ENV env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = ENV::type_id::create("env", this);
	INCL_IFTR_START
    uvm_config_db #(uvm_object_wrapper)::set(this, "env.mast_seqr.main_phase",
                    "default_sequence", SCEN::get_type());
	INCL_IFTR_END
	MAST_START 
    uvm_config_db #(uvm_object_wrapper)::set(this, "env.master_agent.mast_sqr.main_phase",
                    "default_sequence", SCEN::get_type()); 
	MAST_END
  endfunction

endclass : TEST_NAME

`endif //TEST__SV

