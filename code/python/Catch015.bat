reg_aladin.exe -flo D:\MRES\Label\Catch015\CBCT_TO_PCT\C20201229.nii -ref D:\MRES\Label\Catch015\CBCT_TO_PCT\PLabel.nii  -aff D:\MRES\Label\Catch015\txt\C20201229.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 
reg_resample.exe  -flo  D:\MRES\Label\Catch015\20201229.nii -ref D:\MRES\Label\Catch015\PCT.nii -res D:\MRES\Label\Catch015\C\C20201229.nii -inter 0 -trans D:\MRES\Label\Catch015\txt\C20201229.txt 
reg_aladin.exe -flo D:\MRES\Label\Catch015\CBCT_TO_PCT\C20201231.nii -ref D:\MRES\Label\Catch015\CBCT_TO_PCT\PLabel.nii  -aff D:\MRES\Label\Catch015\txt\C20201231.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 
reg_resample.exe  -flo  D:\MRES\Label\Catch015\20201231.nii -ref D:\MRES\Label\Catch015\PCT.nii -res D:\MRES\Label\Catch015\C\C20201231.nii -inter 0 -trans D:\MRES\Label\Catch015\txt\C20201231.txt 
reg_aladin.exe -flo D:\MRES\Label\Catch015\CBCT_TO_PCT\C20210104.nii -ref D:\MRES\Label\Catch015\CBCT_TO_PCT\PLabel.nii  -aff D:\MRES\Label\Catch015\txt\C20210104.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 
reg_resample.exe  -flo  D:\MRES\Label\Catch015\20210104.nii -ref D:\MRES\Label\Catch015\PCT.nii -res D:\MRES\Label\Catch015\C\C20210104.nii -inter 0 -trans D:\MRES\Label\Catch015\txt\C20210104.txt 
reg_aladin.exe -flo D:\MRES\Label\Catch015\CBCT_TO_PCT\C20210108.nii -ref D:\MRES\Label\Catch015\CBCT_TO_PCT\PLabel.nii  -aff D:\MRES\Label\Catch015\txt\C20210108.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 
reg_resample.exe  -flo  D:\MRES\Label\Catch015\20210108.nii -ref D:\MRES\Label\Catch015\PCT.nii -res D:\MRES\Label\Catch015\C\C20210108.nii -inter 0 -trans D:\MRES\Label\Catch015\txt\C20210108.txt 
pause