structure Backend :> BACKEND = struct
  datatype ctype = Bool
                 | Int64

  datatype cparam = CParam of string * ctype

  datatype top_cast = CFunction of string * cparam list * ctype

  datatype cast = CConstInt of int

  fun convertType (Type.Unit) = Bool
    | convertType (Type.Bool) = Bool
    | convertType (Type.I64) = Int64

  local
      open AST
  in
    fun convert a = raise Fail "derp"
    fun convertTop a = raise Fail "derp"
  end
end
