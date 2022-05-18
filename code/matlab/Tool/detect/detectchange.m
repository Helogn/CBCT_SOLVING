% detect change region.

function output = detectchange(img)
sz = size(img);
substact = ones([sz(1),sz(2),sz(3),sz(4)]);
for i = 1 : sz(1)-1

    eval(['substact[',num2str(i),'i,:,:,:] = img[',num2str(i+1),',:,:,:] - img[',num2str(i),',:,:,:]']);
%     eval(['substact[',num2str(i),'i,:,:,:] = substact[',num2str(i),',:,:,:] - substact[',num2str(i),',:,:,:]'])
    eval(['substact[',num2str(i),'i,:,:,:] = substact[',num2str(i+1),',:,:,:] - substact[',num2str(i),',:,:,:]'])

end

end