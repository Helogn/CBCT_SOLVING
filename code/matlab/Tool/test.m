N = 80;
subplot(1,3,1)
imagesc(squeeze(Scan(5,:,:,N)))
view([-90 90])
subplot(1,3,2)
imagesc(squeeze(Scan(6,:,:,N)))
view([-90 90])
subplot(1,3,3)
imagesc(squeeze((Scan(6,:,:,N )-Scan(5,:,:,N ))))
view([-90 90])
colorbar

%%
MIP(squeeze(Scan(5,:,:,: )-Scan(6,:,:,: )),Label,0,1);
imagesc(ans)
