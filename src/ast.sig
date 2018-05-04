signature AST = sig
  datatype binop = Add
                 | Sub
                 | Mul
                 | Div
                 | Eq
                 | LT
                 | LEq
                 | GT
                 | GEq

  datatype ast = ConstInt of int
               | ConstString of string
               | Var of string
               | Binop of binop * ast * ast
               | Funcall of string * ast list

  type fun_name = string
  datatype param = Param of string * Type.ty

  datatype top_ast = Defun of fun_name * param list * Type.ty * ast

  val parse : Parser.sexp -> ast

  val parseToplevel : Parser.sexp -> Type.tenv -> top_ast
end
