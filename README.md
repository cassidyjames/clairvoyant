[![Build Status](https://travis-ci.org/cassidyjames/clairvoyant.svg?branch=master)](https://travis-ci.org/cassidyjames/clairvoyant)


![Icon](data/icons/128.svg)

# Clairvoyant

![Screenshot](data/screenshot.png)


## Ask questions and get psychic answers from this fortune teller

Does he love you? Should you have pizza for dinner? Is there such thing as a stupid question? Discover the answers to these questions and more with Clairvoyant, the magic 8-ball inspired fortune teller.


## Made for [elementary OS](https://elementary.io)

Clairvoyant is designed and developed on and for [elementary OS](https://elementary.io). Purchasing through AppCenter directly supports the development and ensures instant updates straight from me. Get it on AppCenter for the best experience.


## Developing and Building

If you want to hack on and build Clairvoyant yourself, you'll need the following dependencies:

* libgee-0.8-dev
* libgtk-3-dev
* meson
* valac

Run `meson build` to configure the build environment and run `ninja test` to build and run automated tests

    meson build --prefix=/usr
    cd build
    ninja test

To install, use `ninja install`, then execute with `com.github.cassidyjames.clairvoyant`

    sudo ninja install
    com.github.cassidyjames.clairvoyant


## Other Platforms

Clairvoyant is made for elementary OS, but may have been built and made available elsewhere by community members. These builds may have modifications or changes and **are not provided or supported by me**.

