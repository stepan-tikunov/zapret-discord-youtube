@echo off
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "C:\zapret-discord\"
call service.bat status_zapret
call service.bat check_updates
echo:

set "BIN=C:\zapret-discord\bin\"
set "LISTS=C:\zapret-discord\lists\"

start "zapret: discord" /min "%BIN%winws.exe" --wf-tcp=443 --wf-udp=443,50000-50100 ^
--filter-udp=443 --hostlist="%LISTS%list-discord.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --new ^
--filter-tcp=443 --hostlist="%LISTS%list-discord.txt" --dpi-desync=split --dpi-desync-split-pos=1 --dpi-desync-autottl --dpi-desync-fooling=badseq --dpi-desync-repeats=8
