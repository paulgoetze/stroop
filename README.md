# Stroop [![[version]](https://badge.fury.io/rb/stroop.svg)](http://badge.fury.io/rb/stroop)  [![[travis]](https://travis-ci.org/paulgoetze/stroop.png)](https://travis-ci.org/paulgoetze/stroop)

Stroop is a tiny CLI for printing Stroop tests in order to experience the psychological [Stroop effect](https://en.wikipedia.org/wiki/Stroop_effect).

The Stroop effect demonstrates the interference in the reaction time of a task.
The CLI prints a number of color words in 3 different stimuli:

1. Neutral: each words is written in the same color (black)
2. Congruent: the text color and the word refer to the same color
3. Incongruent: the text color and the word do not refer to the same color

## Setup

Install the gem with:

```ruby
gem install stroop
```

## Usage

In the terminal type:

```bash
# printing a neutral stimuli
# (text displayed in one color):
$ stroop neutral 5x10

# printing congruent stimuli
# (text color and word refer to the same color):
$ stroop congruent 5x10

# printing incongruent stimuli
# (text color and word do not refer to the same color):
$ stroop incongruent 5x10
```

This will print you a Stroop test of 10 lines of words with 5 words in each of them.

You can adjust the rows and columns of words by changing the `CxR` param as you like (e.g. `5x2`). If you leave it out a default of `5x10` is used.

For each print out you will find the random seed that was used to generate the color words.

You can also pass a seed by using the `--seed` or `-s` option:

```bash
$ stroop neutral --seed=1234 
$ stroop congruent -s 1234 
$ stroop incongruent -s 1234
```

If you want to use Stroop in Ruby you can run the following code:

```ruby
require 'stroop'

# adjust rows and columns to whatever you like
set = Stroop::Set.new(columns: 5, rows: 10, mode: Stroop::Set::NEUTRAL)
set.to_s # => returns the string of colorized words

# or if you want to pass a specific random seed that is used to generate the set:
set = Stroop::Set.new(columns: 5, rows: 10, mode: Stroop::Set::NEUTRAL, seed: 1234)
set.seed # => returns the random seed that was used to create the color words
```

The available Stroop::Set modes are:

```ruby
Stroop::Set::NEUTRAL     # => :neutral
Stroop::Set::CONGRUENT   # => :congruent
Stroop::Set::INCONGRUENT # => :incongruent
```

## MIT License

Copyright (C) 2015 Paul Götze. Released under the MIT license.
