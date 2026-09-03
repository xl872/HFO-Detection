# HFO-Detection

MATLAB app for automatic detection of high-frequency oscillations (HFOs) in intracranial EEG. It implements the method described in

Liu X, Hu L, Xu C, Xu S, Wang S, Chen Z, Shen J. **An Automatic HFO Detection Method Combining Visual Inspection Features with Multi-Domain Features.** *Neuroscience Bulletin* 2021, 37(6), 777–788. [DOI 10.1007/s12264-021-00659-y](https://doi.org/10.1007/s12264-021-00659-y) | [PMC8192663](https://pmc.ncbi.nlm.nih.gov/articles/PMC8192663/)

## How it works

The pipeline reads an EDF recording, builds a bipolar (or common-average) montage, band-pass filters the signal to the HFO band (default 80 to 250 Hz) with notches at line-noise harmonics, and winsorizes extreme values. Candidate events are found from a Gabor-Morlet time-frequency map and fused with line-length, energy, Teager energy, Hilbert-envelope and SNR features. Candidates are then screened with visual-inspection criteria (number of oscillations, peak-to-valley differences, duration, co-occurring spikes) before being shown in the GUI for review.

## Install

Option 1, the packaged app. Open `installer/HFO_detection_NET_SPIKE.mlappinstall` in MATLAB (built with R2020a) and launch **HFO detection NET&SPIKE** from the Apps tab.

Option 2, from source.

```matlab
addpath(genpath(pwd));   % run from the repository root
HFOgui
```

Requires the Signal Processing Toolbox and the Deep Learning Toolbox (for `mapminmax`). `src/filters/wpd.m` additionally needs the Wavelet Toolbox but is not used by the GUI.

## Layout

| Folder | Contents |
| --- | --- |
| `app/` | GUIDE interface. `HFOgui` is the entry point, `ChannelChose` and `Refresh` are its dialogs |
| `src/detection/` | Detection core. `HFOdetection`, `FeatureExtraction`, `screen`, `SNR`, `spike_detection`, segment merging (`duanchuli`) |
| `src/filters/` | FIR band-pass and notch filters, winsorization, and alternative FFT and wavelet-packet filters |
| `src/timefreq/` | Gabor-Morlet time-frequency analysis and plotting |
| `src/io/` | EDF readers |
| `src/utils/` | Envelope, generalized Hurst exponent, small helpers |
| `scripts/` | `main.m` runs the pipeline without the GUI, `output_result.m` compares detections with annotated events, plus two legacy scripts (`one_signal.fig` is not included) |
| `installer/` | Packaged MATLAB app |

Comments are bilingual, Chinese first and English after the `|` separator.
