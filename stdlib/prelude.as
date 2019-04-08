/**

Stdlib prelude
===============

 This prelude file proposes standard library features that _may_
belong in the _language_ (compiler-internal) prelude sometime, after
some further experience and discussion.  Until then, they live here.

*/

/***

 Not yet implemented
 --------------------

 Mark incomplete code with the `nyi` and `xxx` functions.

 Each have calls are well-typed in all typing contexts, which
trap in all execution contexts.

*/
func nyi() : None = { assert false ; nyi(); };
func xxx() : None = nyi();


/***

 Unreachable
 --------------------

 Mark unreachable code with the `unreachable` function.

 Calls are well-typed in all typing contexts, and they
 trap in all execution contexts.

*/
func impossible() : None = { assert false ; nyi(); };
