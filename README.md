# Inverse Filtering

This project demonstrates the technique of image restoration using inverse filtering in GNU Octave. It focuses on restoring images that have been degraded by known distortions.

## Dataset

The project uses a sample image (included in the repository) to illustrate the process of degradation and subsequent restoration.

## Features

- Simulation of image degradation (motion blur).
- Restoration of degraded images using inverse filtering.
- Analysis of image quality before and after restoration.

## Getting Started

Follow these instructions to get the project up and running on your local machine for development and testing purposes.

### Prerequisites

- GNU Octave (version 8.3.0 or later)
- Image and Statistics packages in Octave

### Installation

Clone this repository:
```bash
git clone https://github.com/annam015/Inverse-Filtering.git
```

## Usage

Open the `inverseFilter.m` script in GNU Octave and run the script. It will demonstrate the process of image degradation (adding motion blur) and then perform the restoration using inverse filtering.
The script will display the original image, the degraded image and the restored image for comparison.

## Understanding the Code

The `inverseFilter.m` script includes functions for:
- Simulating motion blur on an image.
- Applying inverse filtering to restore the blurred image.
- Computing and displaying the Relative Mean Information (RMI) for quality assessment.
