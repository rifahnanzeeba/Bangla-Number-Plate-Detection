# Bangla-Number-Plate-Detection

A vehicle number-plate recognition framework was developed in MATLAB using image preprocessing, connected-component analysis, character segmentation, and template matching. The selected vehicle image was converted into grayscale and binary formats, after which Prewitt edge detection was applied to identify prominent object boundaries. Region-property analysis was used to estimate the probable number-plate location, and the selected region was cropped from the input image.

Morphological area filtering was then applied to remove noise and irrelevant components. Individual plate characters were segmented through connected-component labelling and normalized to a fixed size of 42×24 pixels. Each segmented character was compared with a predefined character-template database using two-dimensional correlation. The template producing the highest correlation value above a predefined threshold was selected as the recognized character. Finally, the recognized characters and numerical digits were arranged into the expected plate format and saved in a text file.

In simpler terms

The code performs the following tasks:

Select vehicle image → convert to grayscale → detect edges → locate plate → crop plate → remove noise → separate characters → compare characters with templates → construct plate number → save result in a text file.

One important limitation is that the code assumes the largest detected region is the number plate, which may not always be correct when other large objects are present in the image.
