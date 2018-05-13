signature TAST = sig
  datatype tast = TConstUnit
                | TConstBool of bool
                | TConstInt of int * Type.ty
                | TVar of string * Type.ty
                | TBinop of AST.binop * tast * tast * Type.ty
                | TCond of tast * tast * tast * Type.ty
                | TCast of Type.ty * tast
                | TProgn of tast list
                | TLet of string * tast * tast
                | TNullPtr of Type.ty
                | TLoad of tast * Type.ty
                | TFuncall of string * tast list * Type.ty

  val typeOf : tast -> Type.ty

  val augment : AST.ast -> Function.stack -> Type.tenv -> Function.fenv -> tast
end