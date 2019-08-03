

if not exist "%USERPROFILE%"\.vim mkdir "%USERPROFILE%"\.vim
if not exist "%USERPROFILE%"\.vim\colors mkdir "%USERPROFILE%"\.vim\colors

set DOT="%~dp0"\dot

type %DOT%\vimrc > %USERPROFILE%\.vimrc
type %DOT%\vimrc.basic > %USERPROFILE%\.vimrc.basic
type %DOT%\colors\monokai.vim > %USERPROFILE%\.vim\colors\monokai.vim

type %DOT%\vimrc.basic %DOT%\ideavimrc > %USERPROFILE%\.ideavimrc
