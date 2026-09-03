function plotTimeFreq(data, TimeLo, TimeHi, TimeStep, FreqLo, FreqHi, FreqStep)

[Nfreq Ntime] = size(data);

x = linspace(TimeLo,TimeHi,Ntime);
Xtick = TimeLo : TimeStep : TimeHi;

logy = linspace(log(FreqLo),log(FreqHi),Nfreq);
Ytick = FreqLo : FreqStep : FreqHi;
imagesc(x,logy,data);
set(gca, ...
    'XTick', Xtick, ...
    'XTickLabel', arrayfun(@num2str, Xtick, 'UniformOutput', false), ...
    'Ydir','normal', ...
    'YTick', log(Ytick), ...
    'YTickLabel', arrayfun(@num2str, Ytick, 'UniformOutput', false));
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('Time-frequency analysis');

end


