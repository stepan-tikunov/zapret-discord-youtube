Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Определим текущую директорию скрипта
scriptPath = fso.GetAbsolutePathName(".")

' Пути к подпапкам
binPath = scriptPath & "\bin\"
listsPath = scriptPath & "\lists\"

' Вызов вспомогательных BAT-файлов
shell.Run """" & scriptPath & "\service.bat"" status_zapret", 0, True
shell.Run """" & scriptPath & "\service.bat"" check_updates", 0, True

' Формируем команду для запуска winws.exe
cmd = """" & binPath & "winws.exe"" " & _
  "--wf-tcp=80,443 --wf-udp=443,50000-50100 " & _
  "--filter-udp=443 --hostlist=""" & listsPath & "list-general.txt"" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=""" & binPath & "quic_initial_www_google_com.bin"" --new " & _
  "--filter-udp=50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --new " & _
  "--filter-tcp=80 --hostlist=""" & listsPath & "list-general.txt"" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new " & _
  "--filter-tcp=443 --hostlist=""" & listsPath & "list-general.txt"" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=midsld --dpi-desync-repeats=8 --dpi-desync-fooling=md5sig,badseq --new " & _
  "--filter-udp=443 --ipset=""" & listsPath & "ipset-cloudflare.txt"" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=""" & binPath & "quic_initial_www_google_com.bin"" --new " & _
  "--filter-tcp=80 --ipset=""" & listsPath & "ipset-cloudflare.txt"" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new " & _
  "--filter-tcp=443 --ipset=""" & listsPath & "ipset-cloudflare.txt"" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=midsld --dpi-desync-repeats=6 --dpi-desync-fooling=md5sig,badseq"

' Запускаем в свернутом режиме
shell.Run cmd, 0, False
