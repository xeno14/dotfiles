#!/usr/bin/env perl

$latex = 'platex -synctex=1 -interaction=nonstopmode %S';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 10;

if ($^O eq 'darwin') {
  $pvc_view_file_via_temporary = 0;
  $pdf_previewer = 'open -ga /Applications/Preview.app';
} else {
  $pdf_previewer = 'xdg-open';
}
