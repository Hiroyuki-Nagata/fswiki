@echo off
echo FSWIKI_HOME=%FSWIKI_HOME%
echo HTMLを生成します。
wiki2html.pl readme.wiki -css=default.css -output=sjis > readme.html
echo PDFを生成します。
wiki2pdf.pl readme.wiki readme.pdf
