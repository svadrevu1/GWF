@echo OFF
@echo "Change Directory"
D:
REM cd .\auto_dem

MKDIR interferogram_out
MKDIR snaphu_export_out

@echo ON
@echo "Graph Processing..."
call "D:\Program Files\snap\bin\gpt.exe" .\graph\DEM-Generation-Pre-Processing.xml
@echo "Graph Processing...DONE"

@echo "Snaphu Export in progress..."
call "D:\Program Files\snap\bin\gpt.exe" SnaphuExport -Ssource=".\interferogram_out\srp_ifgs.dim" -PtargetFolder=.\snaphu_export_out
@echo "Snaphu Export in progress...DONE"

@echo "Copy snaphu files(2 files)..."
call copy D:\auto_dem\snaphu-v1.4.2_win64\bin\* .\snaphu_export_out\srp_ifgs
@echo "Copy snaphu files(2 files)...DONE"

@echo "Snaphu processing..."
call cd D:\auto_dem\snaphu_export_out\srp_ifgs
call "D:\auto_dem\snaphu_export_out\srp_ifgs\snaphu.exe" -f snaphu.conf Phase_ifg_HH_28May2008_04May2008.snaphu.img 5000
@echo "Snaphu processing...DONE"

@echo "Phase Unwrapping and DEM Generation Processing..."
call cd ..\..
call "D:\Program Files\snap\bin\gpt.exe" .\graph\DEM-Generation.xml
@echo "Phase Unwrapping and DEM Generation Processing...DONE"

pause






                                                         