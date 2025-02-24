#!/bin/bash

set -x
echo "Printing numbers divisible by 3 and 5 but not by 15"

for i in {1..100}; do
    if (( (i % 3 == 0 || i % 5 == 0) && i % 15 != 0 )); then
        echo "$i"
    fi
done


#!/bin/bash

echo "Printing numbers divisible by 3 and 5 but not by 15"

for i in {1..100}; do
    if ([ $(expr $i % 3) -eq 0 ] || [ $(expr $i % 5) -eq 0 ]) && [ $(expr $i % 15) -ne 0 ]; then
        echo "$i"
    fi
done

#!/bin/bash
echo "mississippi" | grep -o "s" | wc -l

