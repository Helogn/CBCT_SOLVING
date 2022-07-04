
            #     Path = "reg_f3d -flo D:\MRES\Label\Catch%s\%s.nii -ref D:\MRES\Label\Catch%s\PCT.nii -aff D:\MRES\Label\Catch%s\\txt\C%s.txt  --lncc -5 -vel -cpp D:\MRES\Label\Catch%s\CPP\CPP%s.nii -res D:\MRES\Label\Catch%s\DEF\RES%s.nii -sx -10\n" % (Catch_num,k,Catch_num,Catch_num,k,Catch_num,k,Catch_num,k)
            #     f.write(Path)
            # if A == 2: 
            #     if os.path.exists( Path + "NMI" ) == False:
            #         os.mkdir( Path + "NMI" )
            #     Path = "reg_f3d -flo D:\MRES\Label\Catch%s\%s.nii -ref D:\MRES\Label\Catch%s\PCT.nii -aff D:\MRES\Label\Catch%s\\txt\C%s.txt  --NMI -vel -res D:\MRES\Label\Catch%s\NMI\RES%s.nii -sx -10\n" % (Catch_num,k,Catch_num,Catch_num,k,Catch_num,k)
            #     f.write(Path)