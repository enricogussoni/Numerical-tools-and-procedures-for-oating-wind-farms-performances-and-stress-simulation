plot(freq, psd(:,5))
i=find(positions(:,5)==1)
hold on, plot(freq(i), psd(i,5),'o')