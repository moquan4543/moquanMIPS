#設定專案根目錄
$projectDir = "$PWD"

#創建work
if(-not(Test-Path -Path "$projectDir\.work")){
    Start-Process -NoNewWindow -FilePath "vlib" -ArgumentList "work"
}

#執行ModelSim的編譯指令
Start-Process -NoNewWindow -FilePath "vlog" -ArgumentList "*.v -work work -incr +incdir+" -Wait

#仿真
Write-Output "Starting simulation..."
Start-Process -NoNewWindow -FilePath "vsim" -ArgumentList "work.moquanmips_min_sopc_tb -do `"run -all`"" -Wait
Write-Output "Simulation completed."
