#!/bin/bash

set -x
x=mississippi

grep -o "$1" <<<$x | wc -l
