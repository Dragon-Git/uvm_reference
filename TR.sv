//
// Template for UVM-compliant transaction descriptor
// <TR>         Name of transaction descriptor class
// <BU>         Name of BU descripton class


`ifndef TR__SV
`define TR__SV


class TR extends BU;

   typedef enum {READ, WRITE } kinds_e;
   rand kinds_e kind;
   typedef enum {IS_OK, ERROR} status_e;
   rand status_e status;

   // ToDo: Add constraint blocks to prevent error injection
   // ToDo: Add relevant class properties to define all transactions
   // ToDo: Modify/add symbolic transaction identifiers to match

   constraint TR_valid {
      // ToDo: Define constraint to make descriptor valid
      status == IS_OK;
   }
   MACRO_START  
   `uvm_object_utils_begin(TR) 

      // ToDo: add properties using macros here
   
      `uvm_field_enum(kinds_e,kind,UVM_ALL_ON)
      `uvm_field_enum(status_e,status, UVM_ALL_ON)
   `uvm_object_utils_end
   MACRO_END
 
   extern function new(string name = "Trans");
NORMAL_START
   `uvm_object_utils(TR)
   extern virtual function void do_print(uvm_printer printer = null);
   extern virtual function void do_copy(uvm_object rhs = null);
   extern virtual function bit do_compare(uvm_object rhs,
                                  uvm_comparer comparer = null);
   extern virtual function void do_pack(input uvm_packer packer = null );
   extern virtual function void do_unpack(input uvm_packer packer = null );

NORMAL_END
endclass: TR


function TR::new(string name = "Trans");
   super.new(name);
endfunction: new

NORMAL_START

function void TR::do_print(uvm_printer printer);
   super.do_print(printer); 

   //ToDo: Implement this method here

endfunction: do_print


function void TR::do_copy(uvm_object rhs = null);
   TR to;
   super.do_copy(rhs);
   $cast(to,rhs);
   to.kind = this.kind;

   // ToDo: Copy additional class properties

endfunction: do_copy


function bit TR::do_compare(uvm_object rhs,
                         uvm_comparer comparer); //use of uvm comparer is optional
   TR tr;
   do_compare = super.do_compare(rhs,comparer); 
   if (rhs == null) begin 
      `uvm_fatal("COMPARE", "Cannot compare to NULL instance");
      return 0;
   end

   if (!$cast(tr,rhs)) begin 
      `uvm_fatal("COMPARE", "Attempting to compare to a non TR instance");
      return 0;
   end

   if (this.kind != tr.kind) begin
      return 0;
   end
   // ToDo: Compare additional class properties
   else
   return 1;
endfunction: do_compare


function void TR::do_pack ( input uvm_packer packer);
   super.do_pack(packer);

   // ToDo: Implement this method here
 
endfunction: do_pack


function void TR::do_unpack( input uvm_packer packer); //use of uvm packer is optional
   super.do_unpack(packer);

   // ToDo: Implement this method here

endfunction: do_unpack

NORMAL_END

`endif // TR__SV
