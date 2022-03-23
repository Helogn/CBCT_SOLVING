reg_aladin.exe -flo D:\MRES\Label\Catch001\CBCT_TO_PCT\C2-CT1.nii -ref D:\MRES\Label\Catch001\CBCT_TO_PCT\PLabel.nii  -aff D:\MRES\Label\Catch001\txt\C2-CT1.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 
reg_resample.exe  -flo  D:\MRES\Label\Catch001\2-CT1.nii -ref D:\MRES\Label\Catch001\PCT.nii -res D:\MRES\Label\Catch001\C\C2-CT1.nii -inter 0 -trans D:\MRES\Label\Catch001\txt\C2-CT1.txt 
reg_aladin.exe -flo D:\MRES\Label\Catch001\CBCT_TO_PCT\C2-CT2.nii -ref D:\MRES\Label\Catch001\CBCT_TO_PCT\PLabel.nii  -aff D:\MRES\Label\Catch001\txt\C2-CT2.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 
reg_resample.exe  -flo  D:\MRES\Label\Catch001\2-CT2.nii -ref D:\MRES\Label\Catch001\PCT.nii -res D:\MRES\Label\Catch001\C\C2-CT2.nii -inter 0 -trans D:\MRES\Label\Catch001\txt\C2-CT2.txt 
reg_aladin.exe -flo D:\MRES\Label\Catch001\CBCT_TO_PCT\C2-CT3.nii -ref D:\MRES\Label\Catch001\CBCT_TO_PCT\PLabel.nii  -aff D:\MRES\Label\Catch001\txt\C2-CT3.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 
reg_resample.exe  -flo  D:\MRES\Label\Catch001\2-CT3.nii -ref D:\MRES\Label\Catch001\PCT.nii -res D:\MRES\Label\Catch001\C\C2-CT3.nii -inter 0 -trans D:\MRES\Label\Catch001\txt\C2-CT3.txt 
reg_aladin.exe -flo D:\MRES\Label\Catch001\CBCT_TO_PCT\C2-CT4.nii -ref D:\MRES\Label\Catch001\CBCT_TO_PCT\PLabel.nii  -aff D:\MRES\Label\Catch001\txt\C2-CT4.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 
reg_resample.exe  -flo  D:\MRES\Label\Catch001\2-CT4.nii -ref D:\MRES\Label\Catch001\PCT.nii -res D:\MRES\Label\Catch001\C\C2-CT4.nii -inter 0 -trans D:\MRES\Label\Catch001\txt\C2-CT4.txt 
reg_aladin.exe -flo D:\MRES\Label\Catch001\CBCT_TO_PCT\C2-CT5.nii -ref D:\MRES\Label\Catch001\CBCT_TO_PCT\PLabel.nii  -aff D:\MRES\Label\Catch001\txt\C2-CT5.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 
reg_resample.exe  -flo  D:\MRES\Label\Catch001\2-CT5.nii -ref D:\MRES\Label\Catch001\PCT.nii -res D:\MRES\Label\Catch001\C\C2-CT5.nii -inter 0 -trans D:\MRES\Label\Catch001\txt\C2-CT5.txt 
pause