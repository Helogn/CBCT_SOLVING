import os


Catch_num = "011"
# Catch_num = "007"
# Slice = ['20200406','20200413','20200420','20200501']

Path = "D:\MRES\Label\Catch%s\\" % (Catch_num)
A = 1
# ---reg_aladin
if os.path.exists( Path + "txt" ) == False:
    os.mkdir( Path + "txt" )
def find_cur(string, path):
    # print('cur_dir is %s' % os.path.abspath(path))
    l = []

    # 遍历当前文件，找出符合要求的文件，将路径添加到l中
    for x in os.listdir(path):
        # print(x.split('.')[0])
        if os.path.exists(path + x.split('.')[0] + '.nii'):
            if x.split('.')[1] == string:
                
                l.append (x.split('.')[0])



        # if os.path.isfile(path+'/'+x):
        #     if string in x:
        #         l.append(os.path.abspath(x))
    return l

Slice = find_cur('nii',Path)


with open("Catch" + str(Catch_num)+'.bat', 'w') as f:
    

    for k in (Slice):
        print(k)
        if k != 'PCT' and k != 'Label' and k != 'PLabel' and k!= 'bone_label':
            if A == 1:
                
                aladin = "reg_aladin.exe -flo D:\\MRES\\Label\\Catch%s\\Bone\\Bone%s.nii -ref D:\\MRES\\Label\\Catch%s\\PLabel.nii  -aff D:\MRES\Label\Catch%s\\txt\\%s.txt -rigOnly -ln 4 -lp 3 -%%%%v 100 -%%%%i 60 \n" % (Catch_num,k,Catch_num,Catch_num,k)
                # aladin = "reg_aladin.exe -ref D:\\MRES\\Label\\Catch%s\\%s.nii -flo D:\MRES\Label\Catch%s\PCT.nii -res D:\MRES\Label\Catch%s\T%s.nii -aff D:\MRES\Label\Catch%s\\txt\\%s.txt -rigOnly -ln 4 -lp 3 -%%v 100 -%%i 60 \n" % (Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
                f.write(aladin)
                resample = "reg_resample.exe  -flo  D:\\MRES\\Label\\Catch%s\\%s.nii -ref D:\\MRES\\Label\\Catch%s\\PCT.nii -res D:\\MRES\\Label\\Catch%s\\CBCT_TO_PCT\\C%s.nii -inter 0 -trans D:\MRES\Label\Catch%s\\txt\\%s.txt \n" % ( Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
                f.write(resample)
            if A == 2:
                aladin = "reg_aladin.exe -ref D:\\MRES\\Label\\Catch%s\\%s.nii -flo D:\MRES\Label\Catch%s\PCT.nii -res D:\MRES\Label\Catch%s\T%s.nii -aff D:\MRES\Label\Catch%s\\txt\\%s.txt -rigOnly -ln 4 -lp 3 -%%%%v 100 -%%%%i 60 \n" % (Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
                f.write(aladin)
                resample = "reg_resample.exe  -ref  D:\MRES\Label\Catch%s\%s.nii -flo D:\MRES\Label\Catch%s\Label.nii -res D:\MRES\Label\Catch%s\R%s.nii -inter 0 -trans D:\MRES\Label\Catch%s\\txt\\%s.txt \n" % ( Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
                f.write(resample)
    f.write("pause")

#reg_aladin.exe -ref D:\MRES\Label\Catch011\20200626.nii -flo D:\MRES\Label\Catch011\PCT.nii -res D:\MRES\Label\Catch011\T20200626.nii -aff D:\MRES\Label\Catch011\txt\20200626.txt -rigOnly -ln 4 -lp 3 -%v 100 -%i 60
#reg_resample.exe  -ref  D:\MRES\Label\Catch011\20200626.nii -flo D:\MRES\Label\Catch011\Label.nii -res D:\MRES\Label\Catch011\R20200626.nii -inter 0 -trans D:\MRES\Label\Catch011\txt\20200626.txt

