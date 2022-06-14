import os

# for i in range (16,23):
i = 12
Catch_num = '0' + str(i)



Path = "D:\MRES\Label\Catch_col_%s\\" % (Catch_num)
A = 1
# ---reg_aladin
if os.path.exists( Path + "txt" ) == False:
    os.mkdir( Path + "txt" )
if os.path.exists( Path + "C" ) == False:
    os.mkdir( Path + "C" )
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

Slice = find_cur('nii',Path)


with open("Col_Catch" + str(Catch_num)+'.bat', 'w') as f:

    for k in (Slice):
        print(k)
        # if k != 'PCT' and k != 'Label' and k != 'PLabel' and k!= 'bone_label':
        if A == 1:
            
            aladin = "reg_aladin.exe -flo D:/MRES/Label/Catch_col_%s/CBCT_TO_PCT/C%s.nii -ref D:/MRES/Label/Catch_col_%s/CBCT_TO_PCT/PLabel.nii  -aff D:/MRES/Label/Catch_col_%s/txt/C%s.txt -rigOnly -ln 4 -lp 3 -%%%%v 100 -%%%%i 60 \n" % (Catch_num,k,Catch_num,Catch_num,k)
            # aladin = "reg_aladin.exe -ref D:\\MRES\\Label\\Catch%s\\%s.nii -flo D:\MRES\Label\Catch%s\PCT.nii -res D:\MRES\Label\Catch%s\T%s.nii -aff D:\MRES\Label\Catch%s\\txt\\%s.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 \n" % (Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
            f.write(aladin)
            resample = "reg_resample.exe  -flo  D:/MRES/Label/Catch_col_%s/%s.nii -ref D:/MRES/Label/Catch_col_%s/PCT.nii -res D:/MRES/Label/Catch_col_%s/C/C%s.nii -inter 0 -trans D:/MRES/Label/Catch_col_%s/txt/C%s.txt \n" % ( Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
            f.write(resample)

    f.write("pause")

#reg_aladin.exe -ref D:\MRES\Label\Catch011\20200626.nii -flo D:\MRES\Label\Catch011\PCT.nii -res D:\MRES\Label\Catch011\T20200626.nii -aff D:\MRES\Label\Catch011\txt\20200626.txt -rigOnly -ln 4 -lp 3 -%v 100 -%i 60
#reg_resample.exe  -ref  D:\MRES\Label\Catch011\20200626.nii -flo D:\MRES\Label\Catch011\Label.nii -res D:\MRES\Label\Catch011\R20200626.nii -inter 0 -trans D:\MRES\Label\Catch011\txt\20200626.txt

