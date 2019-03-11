// import List

type X = Nat;

func List__tests() {

  func opnatEq(a : ?Nat, b : ?Nat) : Bool {
    switch (a, b) {
    case (null, null) { true };
    case (?aaa, ?bbb) { aaa == bbb };
    case (_,    _   ) { false };
    }
  };
  func opnat_isnull(a : ?Nat) : Bool {
    switch a {
    case (null) { true };
    case (?aaa) { false };
    }
  };

  // ## Construction
  let l1 = List.nil<X>();
  let l2 = List.push<X>(2, l1);
  let l3 = List.push<X>(3, l2);

  // ## Projection -- use nth
  assert (opnatEq(List.nth<X>(l3, 0), ?3));
  assert (opnatEq(List.nth<X>(l3, 1), ?2));
  assert (opnatEq(List.nth<X>(l3, 2), null));
  //assert (opnatEq (hd<X>(l3), ?3));
  //assert (opnatEq (hd<X>(l2), ?2));
  //assert (opnat_isnull(hd<X>(l1)));

  /*
   // ## Projection -- use nth
   assert (opnatEq(nth<X>(l3, 0), ?3));
   assert (opnatEq(nth<X>(l3, 1), ?2));
   assert (opnatEq(nth<X>(l3, 2), null));
   assert (opnatEq (hd<X>(l3), ?3));
   assert (opnatEq (hd<X>(l2), ?2));
   assert (opnat_isnull(hd<X>(l1)));
   */

  // ## Deconstruction
  let (a1, t1) = List.pop<X>(l3);
  assert (opnatEq(a1, ?3));
  let (a2, t2) = List.pop<X>(l2);
  assert (opnatEq(a2, ?2));
  let (a3, t3) = List.pop<X>(l1);
  assert (opnatEq(a3, null));
  assert (List.isNil<X>(t3));

  // ## List functions
  assert (List.len<X>(l1) == 0);
  assert (List.len<X>(l2) == 1);
  assert (List.len<X>(l3) == 2);

  // ## List functions
  assert (List.len<X>(l1) == 0);
  assert (List.len<X>(l2) == 1);
  assert (List.len<X>(l3) == 2);
};

// Run the tests
List__tests();
