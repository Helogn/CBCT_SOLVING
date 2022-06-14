import os
import numpy as np
# for i in range (16,23):
#i = 13
#Catch_num =  str(i)

def find_cur(string, path):
    # print('cur_dir is %s' % os.path.abspath(path))
    l = []

    # 遍历当前文件，找出符合要求的文件，将路径添加到l中
    for x in os.listdir(path):
        # print(x.split('.')[0])
        if os.path.exists(path + x.split('.')[0] + '.nii'):
            if (x[0] in ['B','L','R','t','T','P']) == 0 :
                if x.split('.')[1] == string:

                    l.append (x.split('.')[0])

    return l



I = np.linspace(13,29,17,dtype = int)
jug1 = 1
jug2 = 1
for i in I:
    Catch_num =  str(i)
    Path = "/home/helognn/data/CATCH_CONTROL_00%s/" % (Catch_num)
    A = 1
#    Catch_num =  str(i)
# ---reg_aladin
    if os.path.exists( Path + "txt" ) == False:
        os.mkdir( Path + "txt" )
    if os.path.exists( Path + "C" ) == False:
        os.mkdir( Path + "C" )

    Slice = find_cur('nii',Path)
    
    
    with open('aladi.sh', 'a') as f:
        if jug1 == 1:
            begin = "#!/bin/sh \n"
            f.write(begin)
            jug1 = 2
        for k in (Slice):
            print(k)
        # if k != 'PCT' and k != 'Label' and k != 'PLabel' and k!= 'bone_label':
            if A == 1:
            
                aladin = "reg_aladin -flo /home/helognn/data/CATCH_CONTROL_00%s/CBCT_TO_PCT/C%s.nii -ref /home/helognn/data/CATCH_CONTROL_00%s/CBCT_TO_PCT/PLabel.nii  -aff /home/helognn/data/CATCH_CONTROL_00%s/txt/C%s.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 & \n" % (Catch_num,k,Catch_num,Catch_num,k)
            # aladin = "reg_aladin.exe -ref D:\\MRES\\Label\\Catch%s\\%s.nii -flo D:\MRES\Label\Catch%s\PCT.nii -res D:\MRES\Label\Catch%s\T%s.nii -aff D:\MRES\Label\Catch%s\\txt\\%s.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 \n" % (Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
                f.write(aladin)
            #resample = "reg_resample  -flo  /home/helognn/data/CATCH_CONTROL_00%s/%s.nii -ref /home/helognn/data/CATCH_CONTROL_00%s/PCT.nii -res /home/helognn/data/CATCH_CONTROL_00%s/C/C%s.nii -inter 0 -trans /home/helognn/data/CATCH_CONTROL_00%s/txt/C%s.txt & \n" % ( Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
            #f.write(resample)

#    f.write("pause")




    with open('resam.sh', 'a') as f:
        if jug2 == 1:

            begin = "#!/bin/sh \n"
            f.write(begin)
            jug2 = 2
        for k in (Slice):
            print(k)
        # if k != 'PCT' and k != 'Label' and k != 'PLabel' and k!= 'bone_label':
            if A == 1:

            #aladin = "reg_aladin -flo /home/helognn/data/CATCH_CONTROL_00%s/CBCT_TO_PCT/C%s.nii -ref /home/helognn/data/CATCH_CONTROL_00%s/CBCT_TO_PCT/PLabel.nii  -aff /home/helognn/data/CATCH_CONTROL_00%s/txt/C%s.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 & \n" % (Catch_num,k,Catch_num,Catch_num,k)
            # aladin = "reg_aladin.exe -ref D:\\MRES\\Label\\Catch%s\\%s.nii -flo D:\MRES\Label\Catch%s\PCT.nii -res D:\MRES\Label\Catch%s\T%s.nii -aff D:\MRES\Label\Catch%s\\txt\\%s.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 \n" % (Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
            #f.write(aladin)
                resample = "reg_resample  -flo  /home/helognn/data/CATCH_CONTROL_00%s/%s.nii -ref /home/helognn/data/CATCH_CONTROL_00%s/PCT.nii -res /home/helognn/data/CATCH_CONTROL_00%s/C/C%s.nii -inter 0 -trans /home/helognn/data/CATCH_CONTROL_00%s/txt/C%s.txt & \n" % ( Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
                f.write(resample)




#reg_aladin.exe -ref D:\MRES\Label\Catch011\20200626.nii -flo D:\MRES\Label\Catch011\PCT.nii -res D:\MRES\Label\Catch011\T20200626.nii -aff D:\MRES\Label\Catch011\txt\20200626.txt -rigOnly -ln 4 -lp 3 -%v 100 -%i 60
#reg_resample.exe  -ref  D:\MRES\Label\Catch011\20200626.nii -flo D:\MRES\Label\Catch011\Label.nii -res D:\MRES\Label\Catch011\R20200626.nii -inter 0 -trans D:\MRES\Label\Catch011\txt\20200626.txt

