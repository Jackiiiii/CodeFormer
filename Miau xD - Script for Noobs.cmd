@echo off
setlocal EnableDelayedExpansion

rem Define the array with options
set "n=0"
for %%a in (
Render_Face_And_Background-----------#Drag_And_Drop
Render_Face_And_Background-----------#All_Pic's_Inside_The_Input_Folder
Render_Only_Face---------------------#Drag_And_Drop
Render_Only_Face---------------------#All_Pic's_Inside_The_Input_Folder
Render_Video-------------------------#Drag_And_Drop ) do (
   set /A n+=1
   set "option[!n!]=%%a"
)

rem Define selected/unselected colors
set "selected=FB"
set "unselected=0B"

for /F %%a in ('echo prompt $H ^| cmd') do set "DEL=%%a"
goto :Start


:ColorText
<NUL set /P "=%DEL% " > "%~2"
findstr /V /A:%1 /R "^$" "%~2" NUL
del "%~2" > NUL 2>&1
exit /B


:Start
set /A "select=1, newSelect=1"
for /L %%i in (2,1,%n%) do set "color[%%i]=%unselected%"

:menu
set "color[%select%]=%unselected%"
set "select=%newSelect%"
set "color[%select%]=%selected%"
cls
echo This LOW Script is made by [101mMIAU:3[0m for noobs;
echo Finished Files will be in the [93mresults[0m Folder inside the Main Folder [93mCodeFormer[0m;
call :ColorText 0A "Menu"
echo/
for /L %%i in (1,1,%n%) do (
   call :ColorText !color[%%i]! "!option[%%i]!"
   echo/
)
call :ColorText 0E "(W and S to scroll and Q to select)"

:choice
choice /C:WSQ /N > NUL
goto Key-%errorlevel%

:1
@echo off
echo WRITE URL OR DRAGE AND DROP FILE and [94mPRESS ENTER[0m
set /p urlinput=""
@echo off
echo "Detail Quality --[91m>[0m (0.1 - 1) [91m<[0m-- Less Detail Quality"
echo WRITE VALUE OR [93mWITHOUT VALUE FOR (DEFAULT)[0m and [94mPRESS ENTER[0m
SET /P "value=" || SET "value=0.7"
start python inference_codeformer.py -w %value% --bg_upsampler realesrgan --face_upsample  --input_path %urlinput%
goto menu
cls

:2
@echo off
echo WRITE URL OR DRAGE AND DROP FILE and [94mPRESS ENTER[0m
set /p urlinput=""
@echo off
echo "Detail Quality --[91m>[0m (0.1 - 1) [91m<[0m-- Less Detail Quality"
echo WRITE VALUE OR [93mWITHOUT VALUE FOR (DEFAULT)[0m and [94mPRESS ENTER[0m
SET /P "value=" || SET "value=0.7"
start python inference_codeformer.py -w %value% --bg_upsampler realesrgan --face_upsample  --input_path inputs
goto menu
cls

:3
@echo off
echo WRITE URL OR DRAGE AND DROP FILE and [94mPRESS ENTER[0m
set /p urlinput=""
@echo off
echo "Detail Quality --[91m>[0m (0.1 - 1) [91m<[0m-- Less Detail Quality"
echo WRITE VALUE OR [93mWITHOUT VALUE FOR (DEFAULT)[0m and [94mPRESS ENTER[0m
SET /P "value=" || SET "value=0.5"
start python inference_codeformer.py -w %value% --has_aligned --input_path inputs  --input_path %urlinput%
goto menu
cls

:4
@echo off
echo WRITE URL OR DRAGE AND DROP FILE and [94mPRESS ENTER[0m
set /p urlinput=""
@echo off
echo "Detail Quality --[91m>[0m (0.1 - 1) [91m<[0m-- Less Detail Quality"
echo WRITE VALUE OR [93mWITHOUT VALUE FOR (DEFAULT)[0m and [94mPRESS ENTER[0m
SET /P "value=" || SET "value=0.5"
start python inference_codeformer.py -w %value% --has_aligned --input_path inputs  --input_path inputs
goto menu
cls

:5
@echo off
echo WRITE URL OR DRAGE AND DROP FILE and [94mPRESS ENTER[0m
set /p urlinput=""
@echo off
echo "Detail Quality --[91m>[0m (0.1 - 1) [91m<[0m-- Less Detail Quality"
echo WRITE VALUE OR [93mWITHOUT VALUE FOR (DEFAULT)[0m and [94mPRESS ENTER[0m
SET /P "value=" || SET "value=1"
@echo off
echo Frames per Second (FPS)
echo WRITE VALUE OR [93mWITHOUT VALUE FOR (DEFAULT)[0m and [94mPRESS ENTER[0m
SET /P "fps=" || SET "fps=24"
start python inference_codeformer.py --bg_upsampler realesrgan --face_upsample -w %value%  --input_path %urlinput% --save_video_fps %fps%
goto menu
cls

:Key-1  W = Up menu
if %select% equ 1 goto choice
set /A newSelect=select-1
goto menu

:Key-2  S = Down menu
if %select% equ %n% goto choice
set /A newSelect=select+1
goto menu

:Key-3  Q = Select current option
echo off
echo [%select%]

:: Compare input through if commands,
:: `if not defined select goto :menu` can be used here if prefered.
if "%select%" equ "1" GOTO 1
if "%select%" equ "2" GOTO 2
if "%select%" equ "3" GOTO 3
if "%select%" equ "4" GOTO 4
if "%select%" equ "5" GOTO 5

pause
goto Start