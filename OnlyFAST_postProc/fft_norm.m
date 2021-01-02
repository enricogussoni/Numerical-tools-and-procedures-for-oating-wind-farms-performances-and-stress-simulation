function [SpectrumPos, frequecy]=fft_norm(data,fsamp)

dim=size(data);

if dim(2)>dim(1)
    data=data';
end

N=length(data);
df=1/(N*1/fsamp);

if (N/2)==(floor(N/2))
    
    frequecy=0:df:(N/2*df);
    NF=length(frequecy);
    SpectrumTot=fft(data,[],1);
    SpectrumPos(1,:)=SpectrumTot(1,:)/N;
    SpectrumPos(2:N/2,:)=SpectrumTot(2:N/2,:)/(N/2);
    SpectrumPos(N/2+1,:)=SpectrumTot(N/2+1,:)/N;
    
else
    
    frequecy=0:df:((N-1)/2)*df;
    NF=length(frequecy);
    SpectrumTot=fft(data,[],1);
    SpectrumPos(1,:)=SpectrumTot(1,:)/N;
    SpectrumPos(2:(N+1)/2,:)=SpectrumTot(2:(N+1)/2,:)/(N/2);
    
end




