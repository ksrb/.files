#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set ekeyboard.commandL2controlL_excustomExpTerm 1
/bin/echo -n .
$cli set ekeyboard.controlL2commandL_excustomExpTerm 1
/bin/echo -n .
$cli set ekeyboard.ctrlLSpace2commandLSpace 1
/bin/echo -n .
$cli set passthrough.escapetab 1
/bin/echo -n .
$cli set remap.commandSpace2commandLshiftLspace 1
/bin/echo -n .
$cli set remap.reverse_both_scrolling 1
/bin/echo -n .
$cli set repeat.initial_wait 400
/bin/echo -n .
$cli set repeat.wait 15
/bin/echo -n .
/bin/echo
