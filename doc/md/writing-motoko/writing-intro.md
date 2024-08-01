---
sidebar_position: 1
---

# Overview

The Motoko programming language is a new, modern and type safe language for developers who want to build the next generation of distributed applications on ICP, as it is specifically designed to support the unique features of ICP while providing a familiar, yet robust, programming environment. As a new language, Motoko is constantly evolving with support for new features and other improvements.

The Motoko compiler, documentation and other tooling is [open source](https://github.com/dfinity/motoko) and released under the Apache 2.0 license. Contributions are welcome.

## Actors

A [canister smart contract](https://internetcomputer.org/docs/current/developer-docs/getting-started/development-workflow) is expressed as a Motoko [actor](actors-async.md). An actor is an autonomous object that fully encapsulates its state and communicates with other actors only through asynchronous messages.

For example, this code defines a stateful `Counter` actor.

``` motoko name=counter file=../examples/Counter.mo
```

Its single public function, `inc()`, can be invoked by this and other actors, to both update and read the current state of its private field `value`.


## Async messages

On ICP, [canisters can communicate](https://internetcomputer.org/docs/current/developer-docs/smart-contracts/call/overview) with other canisters by sending [asynchronous messages](async-data.md). Asynchronous messages are function calls that return a **future**, and use an `await` construct that allows you to suspend execution until a future has completed. This simple feature avoids creating a loop of explicit asynchronous callbacks in other languages.

``` motoko include=counter file=../examples/factorial.mo#L9-L21
```

## Modern type system

Motoko has been designed to be intuitive to those familiar with JavaScript and other popular languages, but offers modern features such as sound structural types, generics, variant types, and statically checked pattern matching.

``` motoko file=../examples/tree.mo
```

## Autogenerated IDL files

A Motoko actor always presents a typed interface to its clients as a suite of named functions with argument and result types.

The Motoko compiler and the IC SDK can emit this interface in a language neutral format called [Candid](candid-ui.md). Other canisters, browser resident code, and mobile apps that support Candid can use the actor’s services. The Motoko compiler can consume and produce Candid files, allowing Motoko to seamlessly interact with canisters implemented in other programming languages (provided they support Candid).

For example, the previous Motoko `Counter` actor has the following Candid interface:

``` candid
service Counter : {
  inc : () -> (nat);
}
```

## Orthogonal persistence

ICP persists the memory and other state of your canister as it executes. The state of a Motoko actor, including its in-memory data structures, survive indefinitely. Actor state does not need to be explicitly restored and saved to external storage.

For example, in the following `Registry` actor that assigns sequential IDs to textual names, the state of the hash table is preserved across calls, even though the state of the actor is replicated across many ICP node machines and typically not resident in memory:

``` motoko file=../examples/Registry.mo
```

## Upgrades

Motoko provides numerous features to help you leverage orthogonal persistence, including the ability to retain a canister’s data as you [upgrade](../canister-maintenance/upgrades.md) the code of the canister.

For example, Motoko lets you declare certain variables as `stable`. These variables are automatically preserved across canister upgrades.

Consider a stable counter:

``` motoko file=../examples/StableCounter.mo
```

It can be installed, incremented *n* times, and then upgraded without interruption:

``` motoko file=../examples/StableCounterUpgrade.mo
```

The `value` was declared `stable`, meaning the current state, *n*, of the service is retained after the upgrade. Counting will continue from *n*, not restart from `0`.

The new interface is compatible with the previous one, allowing existing clients referencing the canister to continue to work. New clients will be able to exploit its upgraded functionality, in this example the additional `reset` function.

For scenarios that can’t be solved using stable variables alone, Motoko provides user-definable upgrade hooks that run immediately before and after an upgrade, allowing you to migrate arbitrary state to stable variables.

## Source code organization

Motoko allows for separating different portions of code out of the `main.mo` file into separate modules. This can be useful for breaking up large pieces of source code into smaller, more manageable pieces.

One common approach is to exclude type definitions from the `main.mo` file and instead include them in a `Types.mo` file.

Another approach is to declare stable variables and public methods in the `main.mo` file, and then break out all the logic and types into other files. This workflow can be beneficial for efficient unit testing.

## Next steps

To start writing Motoko code, start by reading the in-depth documentation for some of the concepts described above:

- [Actors](actors-async.md)

- [Actor classes](actor-classes.md)

- [Async data](async-data.md)

- [Caller identification](caller-id.md)

The Motoko programming language continues to evolve with each release of the [IC SDK](https://internetcomputer.org/docs/current/developer-docs/setup/install) and with ongoing updates to the Motoko compiler. Check back regularly to try new features and see what’s changed.

<img src="https://github.com/user-attachments/assets/844ca364-4d71-42b3-aaec-4a6c3509ee2e" alt="Logo" width="150" height="150" />