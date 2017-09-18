% Ranjeeth KS, University of Calgary, Canada

function [InpData k]= ReadData ()
fid = fopen('D:\Study\ENGO 620\Lab\data\Data.bin' ,'rb');
k = 0; % k stands for k'th epoch
while(k<4295)
    k=k+1; 
    InpData.gpstime(k) = fread(fid,1,'double');
    InpData.numsats(k) = fread(fid,1,'char');
    for m = 1:InpData.numsats(k)
        % m stands for m'th satellite
    InpData.satdata(k).prnID(m) = fread(fid,1,'char');
    InpData.satdata(k).sat_data(m,:) = fread(fid,10,'double');
    end
    
end
    
    
