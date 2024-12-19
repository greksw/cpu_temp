@echo off
REM Получение текущей температуры процессора
for /f "tokens=2 delims== skip=1" %%A in ('wmic /namespace:\\root\wmi path MSAcpi_ThermalZoneTemperature get CurrentTemperature /format:list') do (
    set "temp_raw=%%A"
)

REM Проверка, что temp_raw содержит числовое значение
if not defined temp_raw (
    echo Ошибка: не удалось получить температуру.
    exit /b 1
)

REM Удаляем лишние пробелы
set temp_raw=%temp_raw: =%

REM Перевод температуры из десятых долей Кельвина в градусы Цельсия
set /a temp_cel=(temp_raw / 10) - 273

REM Проверка, что расчет выполнен успешно
if "%temp_cel%"=="" (
    echo Ошибка: не удалось вычислить температуру.
    exit /b 1
)

echo Температура процессора: %temp_cel% °C
pause
