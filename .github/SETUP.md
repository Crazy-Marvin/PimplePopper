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
