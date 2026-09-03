function [ envmax,envmin ] = Env(x)
%插值法求包络 | envelope by spline interpolation through the peaks
%   
xx=1:length(x);
[trs,loc_trs]=findpeaks(x);
envmax=spline(loc_trs,trs,xx);

end

