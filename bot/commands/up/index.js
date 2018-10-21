const shell = require('shelljs');
const megaURLRegex = require('mega-url-regex');

const errmsg = 'Comando formulado incorrectamente.\nEscribe **!ayuda up** para más información.';

function valid(arg) {
  if (!arg.length == 2) {
    return false;
  } else if (!/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/.test(arg[1])) {
    return false;
  }
  return true;
}

function isMegaLink(link) {
  return megaURLRegex({exact: true}).test(link);
}

function isMegaFolder(link) {
  return !megaURLRegex({exact: true, folder: false}).test(link);
}

function reupload(file, target, msg) {
  msg.reply('Resubiendo el archivo...\npuede tardar unos minutos.');

  // if it-s a mega link
  if (target == 'gdrive' && isMegaLink(file)) {
    let folder = false;
    if (isMegaFolder(file)) {
      folder = true;
    }

    shell.exec(`${__dirname}/megatogdrive.sh '${file}' ${folder ? "folder" : "file"}`, function(code, stdout, stderr) {
      const newlink = stdout.match(/https.+/g)[0] || null;
      if (!newlink) {
        msg.reply('No se pudo resubir el archivo.\nEl archivo es demasiado pesado.');
        return;
      }
      msg.reply(`Archivo resubido correctamente.\nEnlace: ${newlink}`);
    });
    return;
  }

  // normal links
  shell.exec(`${__dirname}/${target}.sh ${file}`, function(code, stdout, stderr) {
    const regex = stdout.match(/https.+/g) || null;
    const newlink =  target == 'mega' ? regex[0] : regex[1];
    if (!newlink) {
      msg.reply('No se pudo resubir el archivo :(.\nIntenta con un enlace diferente.');
      return false;
    }
    msg.reply(`Archivo resubido correctamente.\nEnlace: ${newlink}`);
  });
}

module.exports = (arg, msg) => {
  const subcommand = arg[0];
  const link = arg[1];

  if (!valid(arg)) {
    msg.reply(errmsg);
    return;
  }

  switch (subcommand) {
    case 'mega':
    case 'm':
      reupload(link, 'mega', msg);
      break;

    case 'gdrive':
    case 'g':
      reupload(link, 'gdrive', msg);
      break;

    default:
      msg.reply(errmsg);
      return;
  }
}
