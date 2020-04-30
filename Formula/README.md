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

## NoUnary
Next, globally, finally, ... are replaced with their definition.
