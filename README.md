# Sleep Apnea Detection Using EEG

**Institution**: Ryerson University, Biomedical Engineering  
**Course**: BME 772 Project  

## Project Overview

Sleep apnea syndrome (SAS) is a condition that causes frequent interruptions in breathing during sleep. This project presents a method to detect obstructive sleep apnea (OSA), central sleep apnea (CSA), and normal breathing episodes using EEG signal features. EEG data was obtained from the Physionet database, and key features were extracted and analyzed with machine learning classifiers to distinguish between apnea and non-apnea events.

## Dataset

The dataset used in this study is the MIT-BIH Polysomnographic Database from [Physionet](https://physionet.org/content/slpdb/1.0.0/). It includes over 80 hours of sleep recordings from 16 male participants aged 32-56. The dataset provides various physiological signals such as EEG, EMG, and ECG, with annotations for sleep stages and apnea events.

## Methodology

### 1. Preprocessing
- **Filtering**: EEG signals were filtered using IIR bandpass filters to decompose the signals into four sub-bands: delta, theta, alpha, and beta.
- **Noise Reduction**: Two methods of filtering were applied to eliminate noise from EEG signals, including muscle contractions and ocular movements.

### 2. Feature Extraction
From each sub-band of EEG signals, the following features were extracted:
- **Energy**: Indicates the signal's strength.
- **Entropy**: Represents uncertainty in the signal.
- **Variance**: Measures the signal's variability.
- **Form Factor**: Ratio of the first derivative to the original signal.

### 3. Classification
Two machine learning algorithms were used to classify apnea and normal breathing events:
- **Support Vector Machine (SVM)**: Achieved an accuracy of 78.125%, sensitivity of 77.778%, and specificity of 78.571%.
- **K-Nearest Neighbor (KNN)**: Achieved an accuracy of 75%, sensitivity of 64.286%, and specificity of 83.33%.

## Results

The SVM classifier outperformed KNN with higher accuracy and sensitivity. The results show that EEG signal features such as delta wave energy, entropy, and variance are strong indicators for detecting sleep apnea.

| Metric          | SVM            | KNN            |
|-----------------|----------------|----------------|
| **Accuracy**    | 78.125%        | 75.0%          |
| **Sensitivity** | 77.778%        | 64.286%        |
| **Specificity** | 78.571%        | 83.33%         |

## Conclusion

This project demonstrates that EEG signals, combined with machine learning techniques, can be effective in detecting sleep apnea events. Future work could explore using additional physiological signals, more advanced filtering techniques, and larger datasets to improve accuracy.

## Future Work
- Incorporating heart rate and other physiological signals.
- Using k-fold cross-validation to reduce overfitting.
- Developing a web or mobile-based interface for sleep apnea detection.

## How to Use

### Requirements
- Python 3.x
- MATLAB (for preprocessing)
- Libraries: `scikit-learn`, `numpy`, `matplotlib`

### Running the Project
1. Preprocess the EEG data in MATLAB and save the filtered results.
2. Use Python to train the classifiers with the extracted features.
3. Run the classifiers and compare the results.


