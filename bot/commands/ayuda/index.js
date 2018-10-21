const fs = require('fs');
const path = require('path');

const errmsg = 'El comando especificado no existe.';

function valid(arg) {
  const cmdpath = path.join(__dirname, '../', `${arg.length == 1 ? arg[0] : 'ayuda'}`);
  if (!fs.existsSync(cmdpath)) {
    return false;
  } else if (!(arg.length == 1 || arg.length == 0)) {
    return false;
  }
  return cmdpath;
}

module.exports = (arg, msg) => {
  const folder = valid(arg);

  if (!folder) {
    msg.reply(errmsg);
    return;
  }

  fs.readFile(`${folder}/helpfile`, 'utf8', (err, data) => {
    const all = `${data}`.split('/-');
    const helptitle = all[0].split('-=')[0];
    const helpdesc = all[0].split('-=')[1];
    const helpsections = all.slice(1);

    let fields = [];
    for (const field of helpsections) {
      const fieldpart = field.split('-=');
      fields.push({
        name: fieldpart[0],
        value: fieldpart[1]
      });
    }
    
    const embed = {embed: {
      color: 3447003,
      title: helptitle,
      description: helpdesc,
      fields,
      footer: {
        text: `by Kamasado (ヒロ)`,
        icon_url: 'https://cdn.discordapp.com/avatars/173843781748129792/c665669e9aa0e6ddf9a34db14c352df7.png?size=2048'
      }
    }
  }
    msg.channel.send(embed);
  });

  
}
