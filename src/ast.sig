signature AST = sig
  datatype binop = Add
                 | Sub
                 | Mul
                 | Div
                 | Eq
                 | NEq
                 | LT
                 | LEq
                 | GT
                 | GEq

  val binopName : binop -> string

  datatype ast = ConstUnit
               | ConstBool of bool
               | ConstInt of int
               | ConstString of string
               | Var of string
               | Binop of binop * ast * ast
               | Cond of ast * ast * ast
               | Cast of Type.ty * ast
               | Progn of ast list
               | Let of string * ast * ast
               | Assign of string * ast
               | NullPtr of Parser.sexp
               | Load of ast
               | Store of ast * ast
               | Malloc of Parser.sexp * ast
               | Free of ast
               | AddressOf of string
               | Print of ast * newline
               | CEmbed of Parser.sexp * string
               | CCall of string * Parser.sexp * ast list
               | While of ast * ast
               | LetRegion of Type.region * ast
               | MakeRecord of string * (string * ast) list
               | Funcall of string * ast list
       and newline = Newline
                   | NoNewline

  datatype top_ast = Defun of Function.func * ast
                   | Defrecord of string * (string * Type.ty) list
                   | CInclude of string

  val parse : Parser.sexp -> Type.tenv -> ast
  val parseToplevel : Parser.sexp -> Type.tenv -> top_ast
end
