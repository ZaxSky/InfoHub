REM				SETUP
@echo off
TITLE InfoHub
color 0f
mod con cols=80 lines=25
chcp 65001 >nul
cls

:MENU
CLS
CALL :LOGO
echo]
echo ============================================
echo]
echo]
echo Datum:%date%	Uhrzeit: %time%
echo]
echo Bostname:        %COMPUTERNAME%
echo Benutzername:    %USERNAME% 
echo]
echo]
echo]
echo	1. 🖥️ PC INFORMATIONEN
echo]
echo	2. 📶 WLAN INFORMATIONEN
echo]
echo	3. 📋 LOGS
echo]
echo]
echo]
echo	10. 🔘 HERUNTERFAHREN
echo]
echo]
echo ============================================
SET selection=
SET /P selection=Auswahl: 

IF /I '%selection%' == '1' GOTO 1. PC INFORMATIONEN
IF /I '%selection%' == '2' GOTO 2. WLAN INFORMATIONEN
IF /I '%selection%' == '3' GOTO 3. LOGS
IF /I '%selection%' == '10' GOTO 10. HERUNTERFAHREN
GOTO :MENU




:1. PC INFORMATIONEN
CLS
CALL :LOGO

REM Display system information
echo ============================================
echo             PC INFORMATIONEN
echo ============================================
echo]
echo Hostname:        %COMPUTERNAME%
echo Benutzername:    %USERNAME%
echo IP-Adresse(s):
for /f "tokens=2 delims=[]" %%i in ('ping -n 1 %COMPUTERNAME% ^| findstr /R /C:"[0-9]"') do echo     %%i
echo]
systeminfo | findstr /C:"Betriebssystem" /C:"Systemtyp" /C:"Gesamter physischer Speicher" /C:"Verfügbarer physischer Speicher" /C:"Systemstartzeit" /

REM Prozessorinformationen anzeigen
echo]
echo Prozessorinformationen
echo ===========================
wmic cpu get Name, NumberOfCores, NumberOfLogicalProcessors

REM Java-Version anzeigen
echo]
echo Java-Version
echo ===========================
java -version 2>&1 | findstr /C:"version"
echo]

REM Windows-Version anzeigen
echo]
echo Windows-Version
echo ===========================
ver
echo]
echo ============================================
echo]
echo    Zurück zum Menu (ENTER)
echo]
SET selection=
SET /P selection=

IF /I '%selection%' == '1' GOTO :MENU
GOTO :MENU




:2. WLAN INFORMATIONEN
CLS
CALL :LOGO

@echo off
echo ============================================
echo            WLAN INFORMATIONEN
echo ============================================
echo]

REM WLAN-Profilname (SSID) herausfinden
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces ^| findstr "SSID"') do set SSID=%%a

REM Entfernt führende Leerzeichen aus dem SSID-Wert
set SSID=%SSID:~1%

echo Aktuelles WLAN-Profil: %SSID%
echo ------------------------------
echo]

REM Details zur WLAN-Schnittstelle anzeigen
netsh wlan show interfaces

echo]
echo WLAN-Profil-Details:
echo ====================
netsh wlan show profile name="%SSID%" key=clear

echo]
echo Netzwerkverbindungsdetails:
echo ===========================
REM IP-Adresse, Gateway, DNS und andere Informationen anzeigen
ipconfig /all | findstr /C:"IPv4" /C:"Gateway" /C:"DNS" /C:"Subnet Mask" /C:"NetBIOS"

echo]
REM Signalstärke anzeigen (0-100%)
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces ^| findstr "Signal"') do set signal=%%a
echo Signalstärke: %signal:~1%
echo]
echo]
echo ============================================
echo]
echo    Zurück zum Menu (ENTER)
echo]
SET selection=
SET /P selection=

IF /I '%selection%' == '1' GOTO :MENU
GOTO :MENU

:3. EVENT_LOG
CLS
CALL :LOGO
echo]
echo ============================================
echo            	    LOGS
echo ============================================
echo]
eventvwr.msc

echo    Zurück zum Menu (ENTER)
echo]
SET selection=
SET /P selection=

IF /I '%selection%' == '1' GOTO :MENU
GOTO :MENU





:10. HERUNTERFAHREN
CLS
shutdown -s -f -t 10 -c "Wird Heruntergefahren..."

REM				LOGO

: LOGO
echo ██╗███╗   ██╗███████╗ ██████╗     ██╗  ██╗██╗   ██╗██████╗ 
echo ██║████╗  ██║██╔════╝██╔═══██╗    ██║  ██║██║   ██║██╔══██╗
echo ██║██╔██╗ ██║█████╗  ██║   ██║    ███████║██║   ██║██████╔╝
echo ██║██║╚██╗██║██╔══╝  ██║   ██║    ██╔══██║██║   ██║██╔══██╗
echo ██║██║ ╚████║██║     ╚██████╔╝    ██║  ██║╚██████╔╝██████╔╝
echo ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
echo ᴮʸ  ᶻᵃˣˢᵏʸ