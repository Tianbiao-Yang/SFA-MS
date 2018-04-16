# SFA-MS
## REASON
### The present work developed a new alignment algorithm called SFA-MS (Subwindow Factor Analysis based on Mass Spectral information), applying to nontargeted metabolic profiling analysis.By comparing with several alignment methods, it is demonstrated that the method has the capacity to solve the overlapping phenomenon and preserve the shape of peaks and performs well with nonlinear retention time shifts.
## STEP

### 1. First, airPLS algorithm was utilized to proceed background subtraction for high- throughput chromatographic data within a short time.

### 2. On this basis, the Continuous Wavelet Transform with Haar wavelet as the mother wavelet (Haar CWT) are used to determine the position and peak width of the peak. 

### 3. Then,The optimal shifts of each candidate peak were determined by comparing the corresponding mass spectra of the spectrum via the method of subwindow factor analysis (SFA). 

### 4.  Finally,The aligning procedure was accelerated by Fast Fourier Transform cross correlation (FFT cross correlation).
## RESULT
### This approach has been compared with several well-known alignment methods on real data from non-targeted metabolic profiling, which demonstrates that SFA-MS can preserve the shape of peaks and achieve a high quality alignment result for the system of overlapping chromatographic and similar mass spectra. 
