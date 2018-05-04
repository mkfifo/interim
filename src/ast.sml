structure AST :> AST = struct
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

  datatype top_ast = Defun of fun_name * param list * ast

  local
    open Parser
  in
    fun p (Integer i) = ConstInt i
      | p (String s) = ConstString s
      | p (Symbol s) = Var s
      | p (SList [Symbol "+", a, b]) = Binop (Add, p a, p b)
      | p (SList [Symbol "-", a, b]) = Binop (Sub, p a, p b)
      | p (SList [Symbol "*", a, b]) = Binop (Mul, p a, p b)
      | p (SList [Symbol "/", a, b]) = Binop (Div, p a, p b)
      | p (SList [Symbol "=", a, b]) = Binop (Eq, p a, p b)
      | p (SList [Symbol "<", a, b]) = Binop (LT, p a, p b)
      | p (SList [Symbol "<=", a, b]) = Binop (LEq, p a, p b)
      | p (SList [Symbol ">", a, b]) = Binop (GT, p a, p b)
      | p (SList [Symbol ">=", a, b]) = Binop (GEq, p a, p b)
      | p _ = raise Fail "Bad sexp"

    fun parseSexp s = (SOME (p s)) handle (Fail _) => NONE

    fun parseParam (SList [Symbol n, t]) e =
      (case (Type.parseTypeSpecifier t e) of
           (SOME t') => Param (n, t')
         | NONE => raise Fail "Bad type specifier")
      | parseParam _ _ = raise Fail "Bad parameter"

    fun parseToplevel' (SList [Symbol "defun", Symbol name, SList params, body]) e =
      (case (parseSexp body) of
           (SOME body') => Defun (name, map (fn p => parseParam p e) params, body')
         | NONE => raise Fail "Bad body")
      | parseToplevel' _ _ = raise Fail "Bad toplevel node"

   fun parseToplevel s e = (SOME (parseToplevel' s e)) handle (Fail _) => NONE
  end
end
