structure Function :> FUNCTION = struct
  open SymTab

  datatype param = Param of string * Type.ty
  datatype func = Function of string * param list * Type.ty

  type fenv = func SymTab.symtab

  datatype binding = Binding of string * Type.ty
  type stack = binding SymTab.symtab

  fun bindType (Binding (s, t)) = t

  fun funcName (Function (s, _, _)) = s

  fun funcStack (Function (_, params, _)) =
    let fun toStack (Param (n,t)::rest) acc = bind (n, Binding (n, t)) acc
          | toStack nil acc = acc

    in
        toStack params empty
    end
end