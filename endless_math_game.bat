@echo off
setlocal enabledelayedexpansion

:: ゲームの初期設定
set /a time_to_think=10   :: 考える時間（秒）
set /a score=0
set /a total_survival_time=0  :: 生き残っていた時間の合計

:game_loop
cls
echo ---------------------------------------
echo 数式計算ゲーム (エンドレスモード)
echo ---------------------------------------
echo 現在のスコア: %score%
echo ---------------------------------------
set /a num1=%random% %% 10 + 1
set /a num2=%random% %% 10 + 1
set /a num3=%random% %% 10 + 1
set /a num4=%random% %% 10 + 1

:: ランダムで計算の種類を選ぶ（足し算、掛け算、引き算、割り算、掛け算分数）
set /a operation=%random% %% 5

if %operation%==0 (
    set /a answer=%num1% + %num2%
    set question=%num1% + %num2%
    set type=足し算
) else if %operation%==1 (
    set /a answer=%num1% * %num2%
    set question=%num1% * %num2%
    set type=掛け算
) else if %operation%==2 (
    set /a answer=%num1% - %num2%
    set question=%num1% - %num2%
    set type=引き算
) else if %operation%==3 (
    set /a answer=%num1% / %num2%
    set question=%num1% / %num2%
    set type=割り算
) else (
    set /a answer=%num1% * %num3% / %num4%
    set question=%num1% * %num3% / %num4%
    set type=掛け算分数
)

:: 問題を出題 (考える時間)
echo 問題: %question% = ?
echo 考える時間: %time_to_think% 秒

:: 考える時間
set /a countdown=%time_to_think%
set /a question_start_time=%time_to_think%  :: 問題開始時の時間記録
:think_loop
if %countdown% leq 0 goto answer_question
cls
echo ---------------------------------------
echo 数式計算ゲーム (エンドレスモード)
echo ---------------------------------------
echo 現在のスコア: %score%
echo 残り考える時間: %countdown% 秒
echo ---------------------------------------
echo 問題: %question% = ?
set /a countdown-=1
timeout /t 1 >nul
goto think_loop

:answer_question
:: 答えを入力
set /p user_answer=答えを入力してください: 
if "%user_answer%"=="" (
    echo 時間切れ！正しい答えは %answer% でした。
    goto game_over
)

:: ユーザーの答えが正しいかチェック
if "%user_answer%"=="%answer%" (
    echo 正解！ +1ポイント
    set /a score+=1
) else (
    echo 不正解。正しい答えは %answer% です。
    goto game_over
)

:: 生き残っていた時間の追加（考える時間）
set /a survival_time=%time_to_think% - %countdown%
set /a total_survival_time+=%survival_time%

:: 次の問題へ
goto game_loop

:game_over
cls
echo ---------------------------------------
echo ゲーム終了！最終スコアは %score% です。
echo ---------------------------------------
echo あなたが生き残った時間: %total_survival_time% 秒
echo ---------------------------------------
pause
exit /b
