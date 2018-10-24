# Reupload bot (DISCORD)

  This docker image provides a discord bot that uploads files remotely to the cloud (Mega.nz and Google drive).

## **Required environment variables:**
  - **USER** (your Mega account email)
  - **PASS** (your Mega account password)
  - **DRIVE** (your Google Drive [service account](https://console.developers.google.com/iam-admin/serviceaccounts) json key)
  - **TOKENBOT** (your discord bot token)

### Optional:
  - **SSHPORT** (only set this when your container cannot forward ports) (it must be a random number between 1000 and 65535) [Random port generator](https://www.random.org/integers/?num=10&min=1000&max=65535&col=3&base=10&format=html&rnd=new)

## **Starting the bot:**
  After starting the bot you have to link your Google Drive account, so please follow the steps:
  - Run the Image:
  ```
  docker run -p 9595:26 -e USER=<MEGA_EMAIL> -e PASS=<MEGA_PASS> -e DRIVE=<SERVICE_ACCOUNT_KEY> -e TOKENBOT=<DISCORD_TOKEN> -e SSHPORT=<CHOSEN_PORT> kamasado/reupload-discord-bot
  ```
