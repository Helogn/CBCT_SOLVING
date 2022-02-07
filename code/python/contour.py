# import SimpleITK as sitk

# path1 = "D:\\MRES\\DATASETS\\CATCH_0002\\2-CT2\\Nii\\2-CT2.nii"
# path = "D:\\MRES\\Label\\Catch009\\20200407.nii"
# data = sitk.ReadImage(path1)

# out = sitk.GetImageFromArray(data)
# # image = data.get
# print('hello')

import pydicom
import numpy as np
import matplotlib.pyplot as plt
import sys
import glob

# load the DICOM files
# files = "D:\\MRES\\DATASETS\\CATCH_0001\\2-CT1\\DICOM\\"
files = []
print('glob: {}'.format(sys.argv[1]))
for fname in glob.glob(sys.argv[1], recursive=False):
    print("loading: {}".format(fname))
    files.append(pydicom.dcmread(fname))

print("file count: {}".format(len(files)))