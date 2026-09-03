% gmfilterfast.m

function tf = gmfilterfast(signal,gabor)
    %status = statusbar('Filtering ...');
    Nfilters = length(gabor);
    Nsamples = length(signal);
    N = length(gabor{1}.g); % length of largest filter
    NFFT = 2^nextpow2(Nsamples+floor(N/2));
    S = fft(signal,NFFT);
    tf = zeros(Nfilters,Nsamples);
    for i = 1:Nfilters
        kernel = gabor{i}.g + j*gabor{i}.h;
        result = abs(ifft(S .* fft(kernel,NFFT)));
        tf(i,:) = result(floor(length(kernel)/2) + (1:Nsamples));
%         if isempty(statusbar(i/Nfilters,status))
%             break
%         end
    end
%     if ishandle(status)
%         delete(status);
%     end
end