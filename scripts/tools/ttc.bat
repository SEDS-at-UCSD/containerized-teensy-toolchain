@ECHO off

REM //Getting the current directory in the format for cmd command
set slash=/
set dir=%cd%
call set dir=%%cd:\=%slash%%%
set dir=%dir:~2%
set letter=%cd:~0,1%
call SET letter=%%letter:A=a%%
call SET letter=%%letter:B=b%%
call SET letter=%%letter:C=c%%
call SET letter=%%letter:D=d%%
call SET letter=%%letter:E=e%%
call SET letter=%%letter:F=f%%
call SET letter=%%letter:G=g%%
call SET letter=%%letter:H=h%%
call SET letter=%%letter:I=i%%
call SET letter=%%letter:J=j%%
call SET letter=%%letter:K=k%%
call SET letter=%%letter:L=l%%
call SET letter=%%letter:M=m%%
call SET letter=%%letter:N=n%%
call SET letter=%%letter:O=o%%
call SET letter=%%letter:P=p%%
call SET letter=%%letter:Q=q%%
call SET letter=%%letter:R=r%%
call SET letter=%%letter:S=s%%
call SET letter=%%letter:T=t%%
call SET letter=%%letter:U=u%%
call SET letter=%%letter:V=v%%
call SET letter=%%letter:W=w%%
call SET letter=%%letter:X=x%%
call SET letter=%%letter:Y=y%%
call SET letter=%%letter:Z=z%%

set dir=//%letter%%dir%


@if "%1"=="init" ( 
    echo [HOST MSG] Directly run docker container
    echo   usage: docker run -e MODE=init -v %dir%:/root/mount hyun04p/containerized-teensy-toolchain 
) else ^
if "%1"=="build" ( docker run -e MODE=build -v %dir%:/root/mount hyun04p/containerized-teensy-toolchain ) else ^
if "%1"=="clean" ( docker run -e MODE=clean -v %dir%:/root/mount hyun04p/containerized-teensy-toolchain ) else ^
if "%1"=="help" ( 
    echo Usage: ./tcc.bat build
    echo        ./tcc.bat clean
    echo        ./tcc.bat help
) else (
    echo [Invalid] Invalid MODE
    echo    Usage: ./tcc.bat build
    echo           ./tcc.bat clean
    echo           ./tcc.bat help
)




:LoCase
:: Subroutine to convert a variable VALUE to all lower case.
:: The argument for this subroutine is the variable NAME.
GOTO:EOF
