# Final for CS525, Fall, 2022

The final is due Monday, the 12th of December.  The precise due
time is 11:59pm of the due day.

All of your code should be stored in the Final/MySolution directory.
I expect to see that your submitted code is accompanied by a README file
detailing what you have done for this project.

Your final project is expected to be built on top of your midterm project.
If you midterm project is unfinished, please finish it first. If you need
help to do so or just have some questions, please do not hesitate to contact
me ASAP.

## Task 1: Supporting Lazy-Evaluation in LAMBDA

Note that the keyword `$lazy` corresponds to `$delay` in ATS.  The
parser translates `$lazy(...)` into a syntax tree of the form
`T1Mlazy(...)`.  There is also a special function `$eval` of the type
`lazy(X) -> X` that forces the evaluation of a given lazy-value. Note
that `$eval(xs)` corresponds to `!xs` in ATS.

### Primitive Operators for Processing Streams:

  * `strm_nil`: () -> strm(X) // strm-nil
  * `strm_cons`: (X, lazy(strm(X))) -> strm(X) // strm-cons
  * `strm_nilq`: strm(X) -> bool // strm-nil-test
  * `strm_consq`: strm(X) -> bool // strm-cons-test
  * `strm_uncons1`: strm(X) -> X // strm-head
  * `strm_uncons2`: strm(X) -> lazy(strm(X)) // strm-tail

Note that a stream containing elements of type `X` is given the
type `lazy(strm(X))`. The type `strm` corresponds to `stream_con` in ATS.
In terms of functionality, these stream operators behave in the same way as
their list counterparts.


## Task 2: Performing Closure-Conversion for LAMBDA

## Task 3: Writing a term paper on your final project
Typically, the term paper is about 10 page long.

## Task 4: Recording a presentation based on your term paper
Typically, the recording is about 20 minute long.
