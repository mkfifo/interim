signature SET = sig
  type ''a set

  val empty : ''a set
  val add : ''a set -> ''a -> ''a set
  val size : ''a set -> int

  val fromList : ''a list -> ''a set
end