;Copyright (C) 2004-2009 John T. Haller

;Website: http://PortableApps.com/DOSBoxPortable

;This software is OSI Certified Open Source Software.
;OSI Certified is a certification mark of the Open Source Initiative.

;This program is free software; you can redistribute it and/or
;modify it under the terms of the GNU General Public License
;as published by the Free Software Foundation; either version 2
;of the License, or (at your option) any later version.

;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.

;You should have received a copy of the GNU General Public License
;along with this program; if not, write to the Free Software
;Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

!define NAME "DOSBoxPortable"
!define FRIENDLYNAME "DOSBox Portable"
!define APP "DOSBox"
!define VER "1.6.1.0"
!define WEBSITE "PortableApps.com/DOSBoxPortable"

;=== Program Details
Name "${NAME}"
OutFile "..\..\${NAME}.exe"
Caption "${FRIENDLYNAME} | PortableApps.com"
VIProductVersion "${VER}"
VIAddVersionKey ProductName "${FRIENDLYNAME}"
VIAddVersionKey Comments "Allows ${APP} to be run from a removable drive.  For additional details, visit ${WEBSITE}"
VIAddVersionKey CompanyName "PortableApps.com"
VIAddVersionKey LegalCopyright "John T. Haller"
VIAddVersionKey FileDescription "${FRIENDLYNAME}"
VIAddVersionKey FileVersion "${VER}"
VIAddVersionKey ProductVersion "${VER}"
VIAddVersionKey InternalName "${FRIENDLYNAME}"
VIAddVersionKey LegalTrademarks "PortableApps.com is a Trademark of Rare Ideas, LLC."
VIAddVersionKey OriginalFilename "${NAME}.exe"
;VIAddVersionKey PrivateBuild ""
;VIAddVersionKey SpecialBuild ""


;=== Runtime Switches
CRCCheck On
WindowIcon Off
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user
XPStyle On

;=== Include
;(Standard NSIS)
!include TextFunc.nsh
!insertmacro GetParameters

;(Custom)
!include CheckForPlatformSplashDisable.nsh
!include ReadINIStrWithDefault.nsh

;=== Program Icon
Icon "..\..\App\AppInfo\appicon.ico"

Var DISABLESPLASHSCREEN
Var AdditionalParameters
Var ExecString

Section "Main"
	${ReadINIStrWithDefault} $DISABLESPLASHSCREEN "$EXEDIR\${NAME}.ini" "${NAME}" "DisableSplashScreen" "false"
	${ReadINIStrWithDefault} $AdditionalParameters "$EXEDIR\${NAME}.ini" "${NAME}" "AdditionalParameters" ""

	FindProcDLL::FindProc "DOSBox.exe" ;if running, exit
	StrCmp $R0 "1" TheEnd
	
	${CheckForPlatformSplashDisable} $DISABLESPLASHSCREEN
	StrCmp $DISABLESPLASHSCREEN "true" SkipSplash
			;=== Show the splash screen before processing the files
			InitPluginsDir
			File /oname=$PLUGINSDIR\splash.jpg "${NAME}.jpg"
			newadvsplash::show /NOUNLOAD 1200 0 0 -1 /L $PLUGINSDIR\splash.jpg
			
	SkipSplash:
		IfFileExists '$EXEDIR\Data\settings\DOSBox.conf' GetPassedParameters
			CreateDirectory '$EXEDIR\Data\settings'
			CopyFiles /SILENT '$EXEDIR\App\DefaultData\settings\DOSBox.conf' '$EXEDIR\Data\settings'
			
	GetPassedParameters:
		;=== Get any passed parameters
		${GetParameters} $0
		StrCmp "'$0'" "''" "" LaunchProgramParameters

		;=== No parameters
		StrCpy $ExecString `"$EXEDIR\App\DOSBox\DOSBox.exe" -conf "$EXEDIR\Data\settings\DOSBox.conf"`
		Goto AdditionalParameters

	LaunchProgramParameters:
		StrCpy $ExecString `"$EXEDIR\App\DOSBox\DOSBox.exe" -conf "$EXEDIR\Data\settings\DOSBox.conf" $0`

	AdditionalParameters:
		StrCmp $AdditionalParameters "" LaunchNow

		;=== Additional Parameters
		StrCpy $ExecString `$ExecString $AdditionalParameters`

	LaunchNow:
		SetOutPath "$EXEDIR\App\DOSBox"
		Exec $ExecString

	TheEnd:
		newadvsplash::stop /WAIT
SectionEnd