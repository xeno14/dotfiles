#!/usr/bin/env perl

$latex = 'platex -synctex=1 -interaction=nonstopmode -file-line-error %S';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 10;
$pdf_mode	  = 3; # generates pdf via dvipdfmx

if ($^O eq 'darwin') {
  $pvc_view_file_via_temporary = 0;
  $pdf_previewer = 'open -ga Skim';
} else {
  $pdf_previewer = 'xdg-open';
}
