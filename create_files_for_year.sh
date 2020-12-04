#!/bin/bash

YEAR=$1
DIR=$(dirname $(readlink -f $0))

mkdir $DIR/$YEAR

for i in `seq -w 1 25`; do
  mkdir $DIR/$YEAR/day-$i
  touch $DIR/$YEAR/day-$i/README.txt
  cat > $DIR/$YEAR/day-$i/day-$i-part-1.rb <<- EOM
#!/usr/bin/env ruby

file_path = File.expand_path("../day-$i-input.txt", __FILE__)
input     = File.read(file_path)


EOM
  if [ $i -ne '25' ]
  then
    cp $DIR/$YEAR/day-$i/day-$i-part-1.rb $DIR/$YEAR/day-$i/day-$i-part-2.rb
  fi
  touch $DIR/$YEAR/day-$i/day-$i-input.txt
  chmod +x $YEAR/day-$i/*.rb
done
