# Capped #

Cap those mofo infinite loops!

## Installation ##

```sh
gem install capped
```

## Usage ##

Do you have a ```while``` loop that could potentially be infinite?  CAP IT!

```ruby
require 'capped'

x = 0

# Loop while x < 3.  Raise a Capped::LimitExceededError if this
# condition is not met after 10 iterations.
Capped.while(10, ->{ x < 3 } ) do
  x -= 1   # x will always be less than 3   :'(
  puts "Nope"
end
```

Is that ```until``` loop showing you disrespect?  CAP IT!

```ruby
require 'capped'

x = 0

# Loop while x < 3.  Raise a Capped::LimitExceededError if this
# condition is not met after 10 iterations.
Capped.until(10, ->{ x > 3 } ) do
  x -= 1   # x will never be greater than 3   :'(
  puts "Nope"
end

```

Are mixins your thang?

```ruby
include Capped

capped_while(3, ->{ true } ) do
  puts "Nope"
end

capped_until(3, ->{ false } ) do
  puts "Nope"
end
```