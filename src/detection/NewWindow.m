function [fn_wtf] = NewWindow( Nsamples,Nwtf,start_tf,end_tf)
%新的窗 | new window (binary mask of detected segments)
%   此处显示详细说明 | MATLAB template placeholder, detailed explanation goes here

fn_wtf=zeros(1,Nsamples);
for i=1:Nwtf
    fn_wtf(start_tf(i):end_tf(i))=1;
end
fn_wtf=fn_wtf(1:Nsamples);

end

