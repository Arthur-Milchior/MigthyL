This folder contains everything required to represent a MITL formula,
and transform it.

# Auxiliary types

## Interval
Represents a non-singular interval in the non-negative reals.

## Atoms
Represents an atom; either one of the original formula, or a trigger.

# Formulas
Here are the different type, and the way they are transformed into
each other.

## Input
That's the type read by the parser.

The file removeUnary transforms it into:
## NoUnary
Next, globally, finally, ... are replaced with their definition.

The file MakeNnf  transforms it into:
## Nnf
Formulas in negative normal form. It also contains a function which
ensures that each atoms which appear in NNF with a single polarity are
replaced by true.

The file index transforms it into:
## Indexed
Each distinct subformula has a unique index. Equal subformulas are
physically equals.

The file makeImmediate transforms it into:
## Atemporal
Formulas which simply evaluate whether a statement immediatly holds.
