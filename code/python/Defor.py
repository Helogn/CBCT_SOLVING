import os

def find_cur(string, path):
    # print('cur_dir is %s' % os.path.abspath(path))
    l = []

    # 遍历当前文件，找出符合要求的文件，将路径添加到l中
    for x in os.listdir(path):
        # print(x.split('.')[0])
        if os.path.exists(path + x.split('.')[0] + '.nii'):
            if (x[0] in ['c','B','L','R','t','T','P','e']) == 0 :
                if x.split('.')[1] == string:
                    
                    l.append (x.split('.')[0])

    return l

# for i in range (16,23):
T = [3,7,9,11,15,16,19]
for i in T:
    if i <10:
        Catch_num = '00' + str(i)
    else:
        Catch_num = '0' + str(i) 
    Path = "D:\MRES\Label\Catch%s\\" % (Catch_num)
    A = 1
    # ---reg_aladin
    if os.path.exists( Path + "DEF" ) == False:
        os.mkdir( Path + "DEF" )

    Slice = find_cur('nii',Path)


    # with open("Catch" + str(Catch_num)+'.bat', 'w') as f:
    with open("Catch.bat", 'a') as f:

        for k in (Slice):
            print(k)
            # if k != 'PCT' and k != 'Label' and k != 'PLabel' and k!= 'bone_label':
            if A == 1: 
                Path = "reg_f3d -flo D:\MRES\Label\Catch%s\%s.nii -ref D:\MRES\Label\Catch%s\PCT.nii -aff D:\MRES\Label\Catch%s\\txt\C%s.txt  --lncc -5 -vel -cpp D:\MRES\Label\Catch%s\CPP%s.nii -res D:\MRES\Label\Catch%s\RES%s.nii.nii -sx -10\n" % (Catch_num,k,Catch_num,Catch_num,k,Catch_num,k,Catch_num,k)
                f.write(Path)

       
