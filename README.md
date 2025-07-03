# MIB2 High toolbox
The ultimate MIB2-HIGH toolbox for all your MIB2 High customization needs.

Note: this screen has the potential to ruin your MIB2 HIGH unit. The developers are not responsible for any troubles to anyone or anything caused by this toolbox.
It's never our intention to harm any person, car or brand. Use the tools wisely, don't be a douche.

Note2: This is **not** a universal Jailbreak-like solution for all your needs and firmware versions.

Note3: If you're a business that tries to make a profit off of this:  Don't be an asshole, don't charge money for this. This project is done in our free time, out of love for the community. I've risked bricking my own hardware while testing, and invested a lot of time in the research. Instead of making money, why not support this project with your knowledge or a [small donation](https://paypal.me/chillout1) or become a [Patreon](https://patreon.com/jille). 

# Requirements
- Read the entire readme
- At least 1 healthy set of brains
- An MIB2 HIGH or MIB2.5 HIGH infotainment unit. It will **not** work on MIB1 or MIB2 Standard units. Discover Media / Composition Media is not MIB2 HIGH! For MIB2 Standard see the [olli991/mib-std2-pq-zr-toolbox](https://github.com/olli991/mib-std2-pq-zr-toolbox) project.
- 1 empty, **FAT32 formatted** SD-card, with enough space. Everything bigger than 1GB is fine
- Some place to save your backups

## Optional requirements ##
- Python 3, if you want to extract/compress graphics containers (canim/mcf)
- A text-editor, if you want to make your own green menu files or scripts
- Picture editing software, if you want to customize graphics files

# How to install
- If you've installed a previous version (before V4.0) of the toolbox: clean your SD-card before trying to install.
- Download all files from the repository. This can be either as a git clone or "Download zip" from github then extract the zip.
- Put all files and folders on an empty SD-card, preferable >1GB.
- Put the SD-card in one of the slots of your MIB2-unit. 
- Make sure there's only 1 SD-card in your unit, otherwise the scripts don't know where to look.
- Hold the MENU button on your MIB2 until the service screen appears.
- Select the "Software updates/versions" menu, then hit the "Update" button in top right corner.
- Select the SD-card and select MQB Coding MIB2 Toolbox.
- Let the unit run the entire software update. It will reboot several times before showing a screen listing a lot of modules as N/A. The Toolbox line should be Y. You can then hit the back button in the top right corner. 
- When it's done, it will ask you to connect a computer and clear the error codes. This is not needed, you can hit the "Cancel" button..
- The unit will restart one final time and you're back at the main car menu. Installation is now done.
- Hold the MENU button, and go to TESTMODE. On older versions you can go to the developer menu by holding the MENU button for about 10 seconds.
- Go to the Green Developer Menu
- There will be an additional menu called "mqbcoding". When you see this, the installation was succesful.
- Go to mqbcoding, and you will see the following:

![The MQB Coding toolbox menu](https://i.imgur.com/wGUZ4xw.png)

- You're now done.
- Enjoy!

# How to do a manual installation
- Put the mib2-toolbox on an SD-card and insert it into the MIB-unit SD1 slot.
- Make a connection to the debug console of the unit (either via D-Link Dub-E100 or ASIX AX88179 on the USB port, or serial interface on the back of the unit)
- Log in
- Mount the SD card:
  * `mount -uw /net/mmx/fs/sda0` 
- Run the finalScript:  
  * `sh /net/mmx/fs/sda0/Toolbox/final/finalScripts.sh`

- Hold the MENU button, and go to TESTMODE. On older versions you can go to the developer menu by holding the MENU button for about 10 seconds.
- Go to the Green Developer Menu
- There will be an additional menu called "mqbcoding". When you see this, the installation was succesful.
- You're now done.
- Enjoy!

# Green menu screen overview:

```
MQBCoding Main
|
+---Customization                       # Customization features
|   +---Adaptations                     # Adaptation channels
|       +---CarDeviceBUSAssignment
|       +---CarFunctionsList_BAP
|       +---CarFunctionsList_CAN
|       +---CarMenuOperation
|       +---HMI_FunctionBlockingTable
|       +---RCCAdaptions
|       +---VariantInfo
|       +---VehicleConfiguration
|       +---WLAN
|   +---Advanced                        # Import shadow file, FECs pf.conf and such
|   +---AndroidAuto                     # Android Auto custom apps patch
|   +---Coding                          # Long coding editor
|   +---Display                         # Displaymanager and other related features
|   +---GreenMenu                       # Import new GreenMenu screens and scripts
|   +---Language                        # Replacing language data
|   +---Navigation                      # Navigation tweaks, mapstyles switching
|   +---Privacy                         # Privacy features
|   +---Skin                            # Skin graphics import
|   +---Sounds                          # Sounds import (experimental)
|   +---Startup                         # Startup graphics import
|   +---Updates                         # Custom SWDL modes and emergency
|   +---Various                         # Various tweaks
|
+---Disclaimer                          # Some wise words
|
+---Dump                                # Dump various data to SD-card
|
+---History                             # Version history of the Toolbox
|
+---MIB_Information                     # Information about the unit
|   +---Password                        # Password finder
|
+---Uninstall                           # Uninstalls and or cleans up the MIB Toolbox
```

# How to use the new screens
Most screens have a description inside, or show information when running a script. It's always wise to have an SD-card in slot 1.

## dump
Here you can dump various things which you need to customise you unit. Make sure a SD-card is inserted.

## customization
### androidauto
This screen has 2 buttons:
- Patch Android Auto to enable custom third party apps. No root is needed on your phone.
- Recover the original gal.json file in case you didn't like the patch or something is not working right.

### skin
This screen lets you install new images.mcf for each of the 6 skin-folders, from the SkinFiles folder on your SD-card. Use the dump files as a guideline. Don't install any files that are meant for other firmwares because it **will** mess up your graphics and functionalities of your infotainment unit.
This screen will also let you recover the skins from backup.

## greenmenu
This screen will let you import new .esd files from the GreenMenu folder on your SD-card.

# How to use the tools
In the Tools folder you will find a couple of tools:
- extract-canim.py

These are Python-scripts to extract startup screen files (.canim files) in 2 formats. If one of the scripts doesn't extract your canim, try the other one. Both work in the same way: extract_canim.py <filename> <outdir>, for instance: 

```extract_canim.py test.canim .\testfiles\```

- extract-mcf.py
 
This a python script to extract skinfile containers (mcf) and it works similar to the canim-extract: extract_mcf.py <filename> <outdir>, for instance:
 
 ```extract_mcf.py images.mcf .\extracted\```
 
 
- compress-canim.py

This is the script to compress the startup-screens. Make sure you use the same compress-method you used when extracting. Usage: compress-canim.py <original-file> <new-file> <imagesdir>, for instance:

```compress-canim.py test.canim modified.canim .\testfiles\```

- compress-mcf.py
This is the script to compress the MCF-container. Usage: compress-mif.py <original-file> <new-file> <imagesdir>, for instance:
  
```compress-mcf.py images.mcf images2.mcf .\extracted\```

- extract-cff.py
This script can extract images.cff files, container files for navigation icons and materials. Usage: extract-cff.py <output dir>, for instance:
  
```extract-cff.py images.cff c:\extracted\```


## F.A.Q.
If you run into any issues, consult the [F.A.Q.](https://github.com/jilleb/mib2-toolbox/blob/master/FAQ.md).

## Supported firmware versions
This toolbox probably doesn't work on all available firmware versions but the current SD-card installtion proves to be mostly compatible with most firmwares.


# Disclaimer:
**Warning** These screens have the potential to break your unit and void your warranty. Be careful. We are not responsible for any troubles to you, your car or software. MQB Coding is always looking for cool hacks and retrofits to increase the potential of the MQB platform. It's never our intention to harm any person, car or brand.

## Support this project

You're always welcome to support this project with your knowledge, ideas or a [small donation](https://paypal.me/chillout1) to my Paypal or [Patreon](https://patreon.com/jille). 

