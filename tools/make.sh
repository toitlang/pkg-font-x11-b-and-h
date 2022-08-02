#!/bin/sh

TOIT_FONT_TOOLS=third_party/toit-font-tools/app
DIR_B_H=xorg-font-bh-100dpi
TOIT_RUN=toit.run
CONVERT=$TOIT_FONT_TOOLS/convertfont.toit
VERBOSE=
OUTPUT=src

set -e

if [ ! -f "COPYING" -o ! -d "third_party" ]
then
  echo "Please run from top level directory"
  exit 1
fi

git submodule update --recursive --init

mkdir -p src

cp $DIR_B_H/COPYING .

(cd $TOIT_FONT_TOOLS && toit.pkg install)

for size in 08 10 12 14 18 19 24
do
  echo $size
  echo clear
  $TOIT_RUN $CONVERT $VERBOSE $DIR_B_H/lubR$size.bdf "clear_$size" $OUTPUT/clear_$size.toit
  $TOIT_RUN $CONVERT $VERBOSE $DIR_B_H/lubB$size.bdf "clear_${size}_bold" $OUTPUT/clear_${size}_bold.toit &
  $TOIT_RUN $CONVERT $VERBOSE $DIR_B_H/lubI$size.bdf "clear_${size}_italic" $OUTPUT/clear_${size}_italic.toit &
  $TOIT_RUN $CONVERT $VERBOSE $DIR_B_H/lubBI$size.bdf "clear_${size}_bold_italic" $OUTPUT/clear_${size}_bold_italic.toit &
  echo clear_sans
  $TOIT_RUN $CONVERT $VERBOSE $DIR_B_H/luRS$size.bdf "clear_sans_$size" $OUTPUT/clear_sans_$size.toit
  $TOIT_RUN $CONVERT $VERBOSE $DIR_B_H/luBS$size.bdf "clear_sans_${size}_bold" $OUTPUT/clear_sans_${size}_bold.toit &
  $TOIT_RUN $CONVERT $VERBOSE $DIR_B_H/luIS$size.bdf "clear_sans_${size}_italic" $OUTPUT/clear_sans_${size}_italic.toit &
  $TOIT_RUN $CONVERT $VERBOSE $DIR_B_H/luBIS$size.bdf "clear_sans_${size}_bold_italic" $OUTPUT/clear_sans_${size}_bold_italic.toit &
done
