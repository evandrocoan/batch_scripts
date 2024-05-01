
:: start "MeiliSearch" cmd /k "meilisearch --master-key DQoqlq35YUhkLF8tkbtYwCIIer2NM1n5F-_iXtNjbHc

:: https://stackoverflow.com/questions/39551549/q-how-do-you-display-chinese-characters-in-command-prompt/52355476
chcp 936

cd LibreChat
:: start "LibreChat" cmd /k "chcp 936 && npm run backend"
npm run backend

REM this batch file goes at the root of the LibreChat directory (C:/LibreChat/)
