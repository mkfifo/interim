signature TYPE = sig
  datatype ty = Unit
              | Bool
              | U8
              | I8
              | U16
              | I16
              | U32
              | I32
              | U64
              | I64

  type tenv = ty SymTab.symtab

  val parseTypeSpecifier : Parser.sexp -> tenv -> ty
end
