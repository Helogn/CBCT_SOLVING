function plotimg(img,Judge,mi,mx,num)

figure()
imagesc(img)
caxis([mi,mx])
if Judge == 1

    title(strcat('MIP: ',num))
elseif Judge == 2
    title(strcat('AIP: ',num))
end
daspect([1 3 1]);
view([-90 90])
colormap('bone')
colorbar('Ticks',[0,10,20],...
         'TickLabels',{'Cold','gray','Hot'})

end