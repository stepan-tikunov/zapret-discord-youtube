Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Пути
projectDir = "C:\zapret-discord\"
binDir = projectDir & "bin\"
listsDir = projectDir & "lists\"

' Перейти в директорию проекта
shell.CurrentDirectory = projectDir

' Запуск service.bat в скрытом режиме и с ожиданием завершения
shell.Run "service.bat status_zapret", 0, True
shell.Run "service.bat check_updates", 0, True

' Формируем командную строку
exe = """" & binDir & "winws.exe"""
args = " --wf-tcp=443 --wf-udp=443,50000-50100" & _
       " --filter-udp=443 --hostlist=""" & listsDir & "list-discord.txt""" & _
       " --dpi-desync=fake --dpi-desync-repeats=6" & _
       " --dpi-desync-fake-quic=""" & binDir & "quic_initial_www_google_com.bin""" & _
       " --new --filter-udp=50000-50100 --filter-l7=discord,stun" & _
       " --dpi-desync=fake --dpi-desync-repeats=6 --new" & _
       " --filter-tcp=443 --hostlist=""" & listsDir & "list-discord.txt""" & _
       " --dpi-desync=split --dpi-desync-split-pos=1 --dpi-desync-autottl" & _
       " --dpi-desync-fooling=badseq --dpi-desync-repeats=8"

' Полный путь запуска
fullCommand = exe & args

' Запуск winws.exe полностью скрыто
shell.Run fullCommand, 0, False
