import SimpleITK as sitk
import numpy as np
img = sitk.ReadImage("D:\MRES\Label\Catch017\L1.mhd")
path = "D:\MRES\Label\Catch017\RLabel.nii"

Origin = np.array(list(img.GetOrigin()))
# Read the spacing along each dimension
Spacing = np.array(list(img.GetSpacing()))

Dimension = np.array(list(img.GetSize()))




data = sitk.GetArrayFromImage(img)
sz = np.asarray(data)
sz = sz.shape
print(sz)

output = np.zeros(sz)
for i in range(sz[0]):
    for j in range(sz[1]):
        for k in range(sz[2]):
            output[i,j,k] = data[i,sz[1]- j -1,k]

out = sitk.GetImageFromArray(output)


out.SetOrigin(Origin)
out.SetSpacing(Spacing)
sitk.WriteImage(out, path)
