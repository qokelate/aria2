#NoTrayIcon

ProcessClose('aria2c.exe')
ProcessWaitClose('aria2c.exe')

HttpSetProxy(2, '127.0.0.1:14602')

FileClose(FileOpen(@ScriptDir & '\session.dat', 1 + 16))

While 1
	Local $tracker = InetRead('https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt', 1)
	If 0 == @error And @extended Then
		$tracker = BinaryToString($tracker, 4)
		$tracker = StringRegExpReplace($tracker, '\s+', ',')
		$tracker = StringRegExpReplace($tracker, ',+$', '', 1)
		IniWrite(@ScriptDir & "\aria2.conf", 'aria2c', 'bt-tracker', $tracker)
	EndIf
	
	ConsoleWrite(StringFormat('aria2c.exe "--conf-path=%s\\aria2.conf"\n', @ScriptDir))
	RunWait(StringFormat('aria2c.exe "--conf-path=%s\\aria2.conf"', @ScriptDir), @ScriptDir, @SW_HIDE, 0x10000)
	If 0 == @Compiled Then ExitLoop
	Sleep(1000)
WEnd

Exit
