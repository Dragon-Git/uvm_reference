//
// Template for testing the implementation of a UVM-compliant
// transaction descriptor
//
// % vcs -R -sverilog -ntb_opts uvm TR_test.sv
//
// <TR>         Name of transaction descriptor class
// [filename]   TR_test
//

`ifndef TR_TEST__SV
`define TR_TEST__SV

module test;
import uvm_pkg::*;

`include "TR.sv"

initial
begin
   TR obj = new("");
   TR cpy;
   TR sb[$];
   logic [7:0] bytes[];
   string diff;
   int n, m;
   int fp;

      if (!$cast(cpy, obj.clone())) begin
         `uvm_error("CLONE_ERR", "TR::clone() did not allocate a TR instance");
         cpy.print();
      end

	  cpy = new("");
      obj.copy(cpy);
      if (obj == null) begin
         `uvm_error("COPY_ERR", "TR::copy() did not allocate a TR instance");
      end

      if (!cpy.compare(obj)) begin
         `uvm_error("COMPARE_ERR", "TR::copy() did not new-copy/compare: ");
         cpy.print();
      end

      cpy = new("");
      obj.copy(cpy);
      if (!cpy.compare(obj)) begin
         `uvm_error("COPY_ERR_", {"TR::copy() did not copy/compare: ", diff});
         cpy.print();
      end
end

endmodule: test

`endif // TR_TEST__SV
