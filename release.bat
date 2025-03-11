@echo off
:: Verifica se è stata fornita una versione
if "%1"=="" (
    echo Errore: Specificare la nuova versione, esempio: release.bat 1.5.14
    exit /b 1
)

:: Imposta la nuova versione
set VERSION=%1

:: Percorso al file gradle.properties (modifica se necessario)
set GRADLE_PROPERTIES=gradle.properties

:: Sostituisci la versione nel file gradle.properties
echo Aggiornamento del numero di versione a %VERSION%
(for /f "delims=" %%i in ('findstr /v "VERSION_NAME=" %GRADLE_PROPERTIES%') do @echo %%i) > gradle.tmp
echo VERSION_NAME=%VERSION%>>gradle.tmp
move /y gradle.tmp %GRADLE_PROPERTIES% >nul

:: Committa le modifiche
echo Commit delle modifiche...
git add %GRADLE_PROPERTIES%
git commit -m "Release version %VERSION%"

:: Crea il tag
echo Creazione del tag v%VERSION%...
git tag v%VERSION%
git push origin master
git push origin v%VERSION%

:: Fine
echo Versione %VERSION% rilasciata con successo!