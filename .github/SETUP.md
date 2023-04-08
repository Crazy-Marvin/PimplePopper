## Install Godot

- [Install Godot](https://store.steampowered.com/app/404790/Godot_Engine/)
- [Install Android Studio](https://developer.android.com/studio) 
- [Install Temurin 17 (LTS) or later](https://adoptium.net/)
- [Create a debug.keystore (you might have one already)](https://docs.godotengine.org/en/stable/getting_started/workflow/export/exporting_for_android.html#create-a-debug-keystore)
- Go to the Editor Settings --> Android and put the information in
- Go to Project --> Export --> Android (Runnable) and update some information:
    - Version code and Name
    - Unique Name: rocks.poopjournal.pimplepopper
    - Name: Pimple Popper
    - Launcer Icons: Main 192 X 1092: res://icon.png
    - User Data Backup: Allow: On
    - Permissions: Access Network State & Internet
- Click on export project and you are done   

These steps should work on Linux, Windows and macOS.

## Export Android Build

- Download the export templates for the version of Godot that is used (e.g.3.3.3) (Projects → Exports)
![exports](https://user-images.githubusercontent.com/15004217/149666307-6f085e98-0372-4c94-84c0-d0473fcd63ed.jpg)
- In Version → Code you must increase the value by one each time you successfully upload a new version of the game

## Translations

Translations are stored in ```assets/i18n```. Users can contribute them on Crowdin.  
The ```translation.csv``` file holds all keys and values. More details may be found [here](https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_translations.html).

## Yodo1 MAS (ads)

See [https://developers.yodo1.com/docs/godot/get-started/android-integration/](https://developers.yodo1.com/docs/godot/get-started/android-integration/).

Yodo 1 may be en- or disabled in the build settings:  
![ads](https://user-images.githubusercontent.com/15004217/220143947-77f23523-611d-45b9-89c0-b6eb010fd8e6.PNG)
