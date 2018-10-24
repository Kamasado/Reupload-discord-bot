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
  1. Run the Image:
  ```
  docker run -p 9595:26 -e USER=<MEGA_EMAIL> -e PASS=<MEGA_PASS> -e DRIVE=<SERVICE_ACCOUNT_KEY> -e TOKENBOT=<DISCORD_TOKEN> -e SSHPORT=<CHOSEN_PORT> kamasado/reupload-discord-bot
  ```
  2. SSH to your container (password: `dk12`):

  ```
  ssh kamasado@<YOUR_SERVER_IP> -p 9595
  ```

  - **If you used SSHPORT run this instead:**

  ```
  ssh kamasado@serveo.net -p <CHOSEN_PORT>
  ```

  3. Change user password (do not skip this for security reasons):
  ```
  sudo passwd kamasado
  ```

  4. Finally link your GD account:
  ```
  g about
  ```
  Google will give you a link where you have to log in to your Drive account.
  After this, you will be given a code that you have to paste in the terminal.
