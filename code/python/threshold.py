import SimpleITK as sitk
import os
# from Register_code_CBCT_TO_CT import A
def threshold(image_path,im_path,A):
    data = sitk.ReadImage(image_path)
    image1 = sitk.GetArrayFromImage(data)
    image1[image1 < A] = 0
    image1[image1 > A] = 1
    image1[image1 == A] = 1

    origin =  data.GetOrigin()
    spacing = data.GetSpacing()
    direction = data.GetDirection()

    image2 = sitk.GetImageFromArray(image1)
    image2.SetOrigin(origin)
    image2.SetSpacing(spacing)
    image2.SetDirection(direction)

    sitk.WriteImage(image2,im_path)


# for i in range (16,23):
i = 2
Path = 'D:\MRES\Label\Catch00%s\\' % i
# image = '20200527.nii'

if os.path.exists( Path + "CBCT_TO_PCT" ) == False:
    os.mkdir( Path + "CBCT_TO_PCT" )


for x in os.listdir(Path):
    if os.path.exists(Path + x.split('.')[0] + '.nii'):
        if (x[0] in ['B','L','R','t','P','b','C','c']) == 0 :
            threshold(Path + x, Path + 'CBCT_TO_PCT\\C' + x ,150)
    if x.split('.')[0] == 'PCT':
            threshold(Path + x, Path + 'CBCT_TO_PCT\\PLabel.nii' ,150)



