<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/84ace/esp32_smart_keezer">
    <img src="images/logo.png" alt="Logo" width="71" height="83">
  </a>

  <h3 align="center">ESP32 Smart Keezer</h3>

  <p align="center">
    Monitoring the beer flow!
    <br />
    <a href="https://github.com/84ace/esp32_smart_keezer/wiki"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/84ace/esp32_smart_keezer/tree/master/board_images">Board Images</a>
    ·
    <a href="https://github.com/84ace/esp32_smart_keezer/issues">Report Bug</a>
    ·
    <a href="https://github.com/84ace/esp32_smart_keezer/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#main-features">Main Features</a></li>
        <li><a href="#whats-missing">What's Missing</a></li>
      </ul>
    </li>
    <li>
      <a href="#get-the-isolator">Get the Smart Keezer Gear</a>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#made-with">Made with</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![ESP32 Smart Keezer][product-screenshot]](https://github.com/84ace/esp32_smart_keezer/raw/master/enclosure/front_iso.png)

The ESP32 Smart Keezer was created so that we could monitor things inside the Keezer a bit better (so we knew when we were going to run out of beer), and also so we could have a cooler way of displaying what beers were on tap.

<!-- MAIN FEATURES -->
## Main Features:
* Web based  config (webserver)
* 10 channel flow meter
* Charger input (From external MPPT/solar charge controller)
* Current sensors
* Temperature sensor
* 128x32 OLED screen
* Bluetooth (for remote control via phone app)
* WiFi (for debugging)
* USB (micro)
* 30A continuous operation

<!-- WHAT"S MISSING -->
## What's missing:
* A Phone app for remote control / live telemetry

If you would like to contribute an app please contact me via the <a href="https://github.com/84ace/esp32_smart_keezer/tree/master/board_images">issues</a> page.

<!-- GETTING STARTED -->
## Get the Isolator

There are two ways to get started with the ESP32 Battery Isolator: 
* You can either take the easy(er) way and buy a pre-made unit from [here](https://placeholder.com/) 
* you can send the gerber files off to your favourite fab house, order the components, assemble the board and print the enclosure yourself.

Your choice!

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/84ace/esp32_smart_keezer/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- MADE WITH -->
## Made With:
* [KiCad - Electronic Design Automation Suite](https://kicad.org/)
* [Fusion360 - CAD Software](https://www.autodesk.com.au/products/fusion-360/overview)
* [JLCPCB - PCB Fabrication Manufacturer](https://jlcpcb.com/)


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

84ace - [@Racea_Quigg](https://twitter.com/@RaceaQuigg)

Project Link: [https://github.com/84ace/esp32_smart_keezer](https://github.com/84ace)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/84ace/esp32_smart_keezer.svg?style=for-the-badge
[contributors-url]: https://github.com/84ace/esp32_smart_keezer/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/84ace/esp32_smart_keezer.svg?style=for-the-badge
[forks-url]: https://github.com/84ace/esp32_smart_keezer/network/members
[stars-shield]: https://img.shields.io/github/stars/84ace/esp32_smart_keezer.svg?style=for-the-badge
[stars-url]: https://github.com/84ace/esp32_smart_keezer/stargazers
[issues-shield]: https://img.shields.io/github/issues/84ace/esp32_smart_keezer.svg?style=for-the-badge
[issues-url]: https://github.com/84ace/esp32_smart_keezer/issues
[license-shield]: https://img.shields.io/github/license/84ace/esp32_smart_keezer.svg?style=for-the-badge
[license-url]: https://github.com/84ace/esp32_smart_keezer/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/acea-quigg-2007036b/
[product-screenshot]: enclosure/front_iso.png