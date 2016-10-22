#!/bin/sh

echo 'compile'
coffee -o ./ -c coffee/
echo `date '+%y/%m/%d %H:%M:%S'`
mocha
