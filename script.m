uzunluğu belli olmayan bir vector (1x2890) ü 64x... lük hale getir.

208 - Ventricular trigeminy
201 - Ventricular trigeminy

109 - LBBB
111 - LBBB
214 - LBBB

611 - SVTA

Record109 = load('109m','-mat');
[qrs_amp_raw,LBBB_109,delay]=pan_tompkin(Record109.val,360,0);
clear qrs_amp_raw delay Record109

Record111 = load('111m','-mat');
[qrs_amp_raw,LBBB_111,delay]=pan_tompkin(Record111.val,360,0);
clear qrs_amp_raw delay Record111

Record214 = load('214m','-mat');
[qrs_amp_raw,LBBB_214,delay]=pan_tompkin(Record214.val,360,0);
clear qrs_amp_raw delay Record214

Record208 = load('208m','-mat');
[qrs_amp_raw,T_208,delay]=pan_tompkin(Record208.val,360,0);
clear qrs_amp_raw delay Record208

Record201 = load('201m','-mat');
[qrs_amp_raw,T_201,delay]=pan_tompkin(Record201.val,360,0);
clear qrs_amp_raw delay Record201

LBBB_109 = [0 LBBB_109];
LBBB_111 = [0 LBBB_111];
LBBB_214 = [0 LBBB_214];
T_201 = [0 T_201];
T_208 = [0 T_208];

for i=2:length(LBBB_109)
LBBB_109_T(1,i-1) = (LBBB_109(1,i)-LBBB_109(1,i-1))/360;
end

for i=2:length(LBBB_111)
LBBB_111_T(1,i-1) = (LBBB_111(1,i)-LBBB_111(1,i-1))/360;
end

for i=2:length(LBBB_214)
LBBB_214_T(1,i-1) = (LBBB_214(1,i)-LBBB_214(1,i-1))/360;
end

for i=2:length(T_201)
T_201_T(1,i-1) = (T_201(1,i)-T_201(1,i-1))/360;
end

for i=2:length(T_208)
T_208_T(1,i-1) = (T_208(1,i)-T_208(1,i-1))/360;
end

clear LBBB_109 LBBB_111 LBBB_214 T_201 T_208 i

LBBB_T = [LBBB_109_T LBBB_111_T LBBB_214_T];
clear LBBB_109_T LBBB_111_T LBBB_214_T
T_T = [T_201_T T_208_T];
clear T_201_T T_208_T

LBBB_T_Length = length(LBBB_T)-mod(length(LBBB_T),64);
LBBB_T_Adjusted = reshape(LBBB_T(1:LBBB_T_Length), 64, [])';
clear LBBB_T_Length LBBB_T

T_T_Length = length(T_T)-mod(length(T_T),64);
T_T_Adjusted = reshape(T_T(1:T_T_Length), 64, [])';
clear T_T T_T_Length

LBBB_Training = LBBB_T_Adjusted(1:74,:);
LBBB_Test = LBBB_T_Adjusted(75:end,:);

T_Training = T_T_Adjusted(1:51,:);
T_Test = T_T_Adjusted(52:end,:);

clear LBBB_T_Adjusted T_T_Adjusted

Mean_LBBB = mean(LBBB_Training,2);
Mean_T = mean(T_Training,2);

STD_LBBB = std(LBBB_Training,0,2);
STD_T = std(T_Training,0,2);

for i=1:length(LBBB) %74
Mean_LBBB(i,1)=60*64/((LBBB(i,end)-LBBB(i,1))/360);
end
clear i
for i=1:length(T) % 51
Mean_T(i,1)=60*64/((T(i,end)-T(i,1))/360);
end
clear i


