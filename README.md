# my_vocaster

```
curl -s https://raw.githubusercontent.com/nobler1050/my_vocaster/refs/heads/main/install.sh | bash
```

# My Vocaster Setup

This repository contains my personal audio setup configuration for the Focusrite Vocaster Two on Fedora 41, enabling simultaneous audio from a Linux laptop and an Xbox Series X through the TRRS port.

## Overview

This setup leverages the Focusrite Vocaster Two's capabilities to mix audio from various sources, providing a flexible audio solution for streaming, podcasting, or general use. It allows for:

* Simultaneous audio input from a Linux laptop and an Xbox Series X.
* XLR microphone input with the Vocaster's host mic channel.
* Use of the Vocaster's guest mic mute button to toggle microphone inclusion in the TRRS port output (Xbox audio).
* Use of the Vocaster's enhance button to toggle host microphone monitoring in the main mix.

## Requirements

To utilize this configuration, you'll need the following:

* A Focusrite Vocaster Two audio interface.
* A Linux system (tested on Fedora 41).
* An Xbox Series X with an Astro A40 MixAmp.
* An XLR microphone.
* Speakers and Headphones.
* The `alsa-scarlett-gui` tool for managing the Vocaster's settings: [https://github.com/geoffreybennett/alsa-scarlett-gui.git](https://github.com/geoffreybennett/alsa-scarlett-gui.git)
* The `alsa-ucm-conf` package for UCM configuration: [https://github.com/geoffreybennett/alsa-ucm-conf](https://github.com/geoffreybennett/alsa-ucm-conf)

## Installation and Configuration

1.  **Install `alsa-scarlett-gui`:**
    * Follow the installation instructions provided in the `alsa-scarlett-gui` repository.
2.  **Install `alsa-ucm-conf`:**
    * Follow the installation instructions provided in the `alsa-ucm-conf` repository.
3.  **Vocaster Two Setup:**
    * Connect your XLR microphone to the Vocaster's host mic input.
    * Connect your speakers and headphones to the appropriate outputs.
    * Connect the Astro A40 MixAmp's TRRS output to the Vocaster's TRRS input.
4.  **Configuration with `alsa-scarlett-gui`:**
    * Open `alsa-scarlett-gui`.
    * Configure your input and output routing as shown in the screenshots (coming soon).
    * Utilize the guest mic mute button to control the microphone's presence in the TRRS output.
    * Utilize the enhance button to toggle host mic monitoring.
5.  **Mixer Settings:**
    * Adjust the volume levels for your microphone, speakers, headphones, and Xbox audio to your preference.
    * (Screenshots of mixer settings will be added soon)

## Usage

* Once configured, you can
* Use the guest mic mute button to toggle your microphone's output to the Xbox.
* Use the enhance button to toggle microphone monitoring in your headphones.

## Screenshots

* (Add screenshots of your `alsa-scarlett-gui` settings and mixer settings here.)

## Notes

* This configuration is tailored to my specific hardware and preferences. You may need to adjust settings to suit your own setup.
* This setup relies heavily on the `alsa-scarlett-gui` and `alsa-ucm-conf` projects. Please refer to their respective repositories for detailed documentation.

## Contributing

Contributions are welcome! If you have any improvements or suggestions, please feel free to submit a pull request or open an issue.

## License

(Add your license here, e.g., MIT, GPL, etc.)
