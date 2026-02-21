

@echo off         

IF [%1]==[] (

 bun run start

)ELSE (

 bun run %*

)

