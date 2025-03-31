@echo off
setlocal enabledelayedexpansion

:: �Q�[���̏����ݒ�
set /a time_to_think=10   :: �l���鎞�ԁi�b�j
set /a score=0
set /a total_survival_time=0  :: �����c���Ă������Ԃ̍��v

:game_loop
cls
echo ---------------------------------------
echo �����v�Z�Q�[�� (�G���h���X���[�h)
echo ---------------------------------------
echo ���݂̃X�R�A: %score%
echo ---------------------------------------
set /a num1=%random% %% 10 + 1
set /a num2=%random% %% 10 + 1
set /a num3=%random% %% 10 + 1
set /a num4=%random% %% 10 + 1

:: �����_���Ōv�Z�̎�ނ�I�ԁi�����Z�A�|���Z�A�����Z�A����Z�A�|���Z�����j
set /a operation=%random% %% 5

if %operation%==0 (
    set /a answer=%num1% + %num2%
    set question=%num1% + %num2%
    set type=�����Z
) else if %operation%==1 (
    set /a answer=%num1% * %num2%
    set question=%num1% * %num2%
    set type=�|���Z
) else if %operation%==2 (
    set /a answer=%num1% - %num2%
    set question=%num1% - %num2%
    set type=�����Z
) else if %operation%==3 (
    set /a answer=%num1% / %num2%
    set question=%num1% / %num2%
    set type=����Z
) else (
    set /a answer=%num1% * %num3% / %num4%
    set question=%num1% * %num3% / %num4%
    set type=�|���Z����
)

:: �����o�� (�l���鎞��)
echo ���: %question% = ?
echo �l���鎞��: %time_to_think% �b

:: �l���鎞��
set /a countdown=%time_to_think%
set /a question_start_time=%time_to_think%  :: ���J�n���̎��ԋL�^
:think_loop
if %countdown% leq 0 goto answer_question
cls
echo ---------------------------------------
echo �����v�Z�Q�[�� (�G���h���X���[�h)
echo ---------------------------------------
echo ���݂̃X�R�A: %score%
echo �c��l���鎞��: %countdown% �b
echo ---------------------------------------
echo ���: %question% = ?
set /a countdown-=1
timeout /t 1 >nul
goto think_loop

:answer_question
:: ���������
set /p user_answer=��������͂��Ă�������: 
if "%user_answer%"=="" (
    echo ���Ԑ؂�I������������ %answer% �ł����B
    goto game_over
)

:: ���[�U�[�̓��������������`�F�b�N
if "%user_answer%"=="%answer%" (
    echo �����I +1�|�C���g
    set /a score+=1
) else (
    echo �s�����B������������ %answer% �ł��B
    goto game_over
)

:: �����c���Ă������Ԃ̒ǉ��i�l���鎞�ԁj
set /a survival_time=%time_to_think% - %countdown%
set /a total_survival_time+=%survival_time%

:: ���̖���
goto game_loop

:game_over
cls
echo ---------------------------------------
echo �Q�[���I���I�ŏI�X�R�A�� %score% �ł��B
echo ---------------------------------------
echo ���Ȃ��������c��������: %total_survival_time% �b
echo ---------------------------------------
pause
exit /b
