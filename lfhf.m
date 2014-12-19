function W = lfhf( input )
%LFHF Summary of this function goes here
%   Detailed explanation goes here
xRR = transpose(input);
tm = cumsum(xRR)./1000;

for i=1:size(xRR,2)
    t = tm(:,t);
    h = xRR(:,t);
    ofac = 4;
    hifac = 1;
    
    %sample length and time span
    N = length(h);
    T = max(t) - min(t);
 
    %mean and variance 
    mu = mean(h);
    s2 = var(h);
    %calculate sampling frequencies
    f = (1/(T*ofac):1/(T*ofac):hifac*N/(2*T)).';
    %angular frequencies and constant offsets
    w = 2*pi*f;
    tau = atan2(sum(sin(2*w*t.'),2),sum(cos(2*w*t.'),2))./(2*w);

    %spectral power 
    cterm = cos(w*t.' - repmat(w.*tau,1,length(t)));
    sterm = sin(w*t.' - repmat(w.*tau,1,length(t)));
    P = (sum(cterm*diag(h-mu),2).^2./sum(cterm.^2,2) + ...
         sum(sterm*diag(h-mu),2).^2./sum(sterm.^2,2))/(2*s2);

     PL=P;
     PH=P;
     fL=(f>0.04)&(f<0.15);
     PL(fL==0)=0;
     fH=(f>=0.15)&(f<0.4);
     PH(fH==0)=0;
     
     W(i)=sum(PL)./sum(PH);
end

W = transpose(W);

end

