//
// Template for UVM-compliant transaction descriptor
//
// <TX>         Name of transaction descriptor class

`ifndef TX__SV
`define TX__SV

class TX extends uvm_sequence_item;

   // ToDo: Modify/add symbolic transaction identifiers to match
   typedef enum {READ, WRITE } kinds_e;
   rand kinds_e kind;

   // ToDo: Add relevant class properties to define all transactions

   // ToDo: Modify/add symbolic transaction identifiers to match
   typedef enum {IS_OK, ERROR} status_e;
   rand status_e status;

   constraint TX_valid {
      // ToDo: Define constraint to make descriptor valid
      status == IS_OK;
   }

MACRO_START
   `uvm_object_utils_begin(TR)
      `uvm_field_enum(kinds_e,kind,UVM_ALL_ON)
      `uvm_field_enum(status_e,status, UVM_ALL_ON)
      // ToDo: add properties using macros here

   `uvm_object_utils_end(TR)
MACRO_END

NORMAL_START
   // ToDo: Add constraint blocks to prevent error injection
   extern function new(string name = "");
   extern virtual function string sprint(uvm_printer printer = null);
   extern virtual function uvm_sequence_item clone();
   extern virtual function uvm_sequence_item copy(uvm_sequence_item cpy = null);
   extern virtual function bit compare(uvm_sequence_item rhs
                                       uvm_comparer comparer = null);
   extern virtual function int unsigned pack(ref  bit   bitstream [],
                                                  input uvm_packer packer = null );
   extern virtual function int unsigned unpack(ref  bit   bitstream [],
                                                  input uvm_packer packer = null );

NORMAL_END

endclass: TX


NORMAL_START
function TR::new(string name = "");
   super.new("");
endfunction: new


function string TR::sprint(uvm_printer printer);

   //ToDo: Implement this method here

endfunction: sprint


function uvm_sequence_item TR::clone();
   TR tr = new(this.get_name());
   clone = tr;
endfunction: clone


function uvm_sequence_item TR::copy(uvm_sequence_item cpy = null);
   TR to;

   // Copying to a new instance?
   if (cpy == null)
      to = new(this.get_name());
    else
      // Copying to an existing instance. Correct type?
      if (!$cast(to, cpy)) begin
         `uvm_fatal ("copy_error","Attempting to copy to a non TR instance");
         return null;
     end

   super.copy_data(to);

   to.kind = this.kind;

   // ToDo: Copy additional class properties
   copy = to;
endfunction: copy


function bit TR::compare(uvm_sequence_item   to,
                         uvm_comparer comparer); //use of uvm comparer is optional
   TR tr;

   compare = 0;
   if (to == null) begin
      `uvm_fatal("COMPARE", "Cannot compare to NULL instance");
      return 0;
   end

   if (!$cast(tr,to)) begin
      `uvm_fatal("COMPARE", "Attempting to compare to a non TR instance");
      return 0;
   end

   if (this.kind != tr.kind) begin
      $sformat(diff, "Kind %0s != %0s", this.kind, tr.kind);
      return 0;
   end
   // ToDo: Compare additional class properties

   compare = 1;
endfunction: compare


funcion int unsigned TR::pack ( ref bit bitstream[]),
                                input uvm_packer packer);
   // ToDo: Implement this method

endfunction: pack


function int unsigned TR::unpack( ref bit bitstream[],
                                  input uvm_packer packer); //use of uvm packer is optional
   // ToDo: Implement this method

endfunction: unpack

NORMAL_END

`endif // TX__SV
