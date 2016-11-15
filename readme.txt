How many ways can you make 100 out of the sequence of non-zero digits
987654321 in order by placing arithmetic signs in between them.
+, -, /, *

Example: 98/7+6*5...

Consider the nine descending sequenced digits with a "bucket" to place an
operator in between each digit. We have 5 operators (+. -, /, *,'combine'),
so 8 buckets with 5 possible choices yields 5^8
possibilities (390625). 
NOTE: If we include the leading minus sign, possibilities increases to 5^9
FUTURE: Implement modulus operator (%). Where would this fit in the order
of operations...?

1. Brute force approach: Generate base 5 numbers from 000000000 to 444444444 to cover all
posibilities. 
2. Order of operations I.Combine; II. Multiply and Divide; III. Add and
subtract