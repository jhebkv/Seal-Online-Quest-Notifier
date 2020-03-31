#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
version="1.1"
questini=%A_ScriptDir%\QuestTime.ini
IniRead,ql,%questini%,Quest,Lists
Gui,Add,Text,xm w65 h15,Quest Item
Gui,Add,Text,x+p,:
Gui,Add,ComboBox,x+m w120 vQuest choose1 gQuest,%ql%
Gui,Add,Text,xm w65 h15,Notify on
Gui,Add,Text,x+p,:
Gui,Add,Edit,x+m w120 vTime_ gTime_ +number
Gui,Add,Button,x+m w70 gSubmit vSubmit,Start Timer
Gui,Add,Text,xm vNow,%A_Hour%:%A_Min%:%A_Sec%
Gui,Add,Text,x+m,|
Gui,Add,Text,x+m vTimer w60
Gui,Show,w300 h80,Seal Online Quest Timer
goto Quest
return

Quest:
Gui,Submit,Nohide
IniRead,Timer,%questini%,Time,%Quest%
Temp:=getQuestTime(Timer)
GuiControl,,Timer,Timer : %Temp%
GuiControl,,Time_,%Timer%
return

Time_:
Gui,Submit,Nohide
IniWrite,%Time_%,%questini%,Time,%Quest%
return

Submit:
Gui,Submit,Nohide
if (getTimerStat()=0) {
	GuiControl,,Submit,Stop Timer
	Gui,+AlwaysOnTop
}
else {
	GuiControl,,Submit,Start Timer
	Gui,-AlwaysOnTop
}
SetTimer,Timer,10
return

Timer:
Temp:=getQuestTime(Timer)
sleep 10
GuiControl,,Timer,Timer : %Temp%
GuiControl,,Now,%A_Hour%:%A_Min%:%A_Sec%
if (Temp=5) {
	SoundPlay,%a_scriptdir%\audio\Countdown.mp3
	Sleep 1010
}
if getTimerStat()=0
	SetTimer,Timer,Off
sleep 10
return

GuiEscape:
Reload
GuiClose:
ExitApp

getTimerStat(){
	global Submit
	GuiControlGet,Submit,,Submit
	if (Submit="Start Timer")
		return 0
	else
		return 1
}
getQuestTime(Timer){
	if (A_Sec<=Timer)
		Next:=Timer-A_Sec
	else
		Next:=60-A_Sec+Timer
	return Next
}
