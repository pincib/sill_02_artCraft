#!/usr/bin/env node

/**
 * ArtCraft Multi-Agent Suite - CLI Installer & Manager
 * Compatible with npm, npx, pnpm and Antigravity
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const c = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  cyan: '\x1b[36m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  magenta: '\x1b[35m',
  red: '\x1b[31m',
  gray: '\x1b[90m',
};

const userHome = os.homedir();
const homeFormatted = userHome.replace(/\\/g, '/');
const geminiConfig = path.join(userHome, '.gemini', 'config');
const skillsTargetDir = path.join(geminiConfig, 'skills');
const mcpConfigFile = path.join(geminiConfig, 'mcp_config.json');

const packageRoot = path.resolve(__dirname, '..');
const sourceSkillsDir = path.join(packageRoot, 'skills');

const SKILL_NAMES = [
  'artcraft',
  'artcraft-frontend',
  'artcraft-image',
  'artcraft-pitchdeck',
  'artcraft-sheet',
  'artcraft-video',
];

const CRAFT_APPS = [
  { id: 'deckcraft', name: 'DeckCraft', args: ['mcp', '--automation-read-root', homeFormatted, '--automation-write-root', homeFormatted] },
  { id: 'designcraft', name: 'DesignCraft', args: ['mcp', '--automation-read-root', homeFormatted, '--automation-write-root', homeFormatted] },
  { id: 'effectcraft', name: 'EffectCraft', args: ['mcp', '--automation-read-root', homeFormatted, '--automation-write-root', homeFormatted] },
  { id: 'figcraft', name: 'FigCraft', args: ['mcp', '--automation-read-root', homeFormatted, '--automation-write-root', homeFormatted] },
  { id: 'filmcraft', name: 'FilmCraft', args: ['mcp', '--compact'] },
  { id: 'gridcraft', name: 'GridCraft', args: ['mcp'] },
  { id: 'lightcraft', name: 'LightCraft', args: ['mcp', '--compact'] },
  { id: 'pdfcraft', name: 'PdfCraft', args: ['mcp', '--compact', '--automation-read-root', homeFormatted, '--automation-write-root', homeFormatted] },
  { id: 'photocraft', name: 'PhotoCraft', args: ['mcp', '--automation-read-root', homeFormatted, '--automation-write-root', homeFormatted] },
  { id: 'vectorcraft', name: 'VectorCraft', args: ['mcp', '--headless', '--automation-read-root', homeFormatted, '--automation-write-root', homeFormatted] },
  { id: 'wordcraft', name: 'WordCraft', args: ['mcp', '--automation-read-root', homeFormatted, '--automation-write-root', homeFormatted] },
];

function printBanner() {
  console.log(`${c.magenta}${c.bright}=================================================================${c.reset}`);
  console.log(`${c.magenta}${c.bright}  ArtCraft Multi-Agent Suite - NPM / NPX Installer (Antigravity)${c.reset}`);
  console.log(`${c.magenta}${c.bright}=================================================================${c.reset}\n`);
}

function resolveCommandPath(app) {
  if (process.platform === 'win32') {
    return `C:/Program Files/${app.name}/${app.id}-cli.exe`;
  } else if (process.platform === 'darwin') {
    return `/Applications/${app.name}.app/Contents/MacOS/${app.id}-cli`;
  } else {
    return `${app.id}-cli`;
  }
}

function checkAppExists(cmdPath) {
  if (process.platform === 'win32') {
    const winPath = cmdPath.replace(/\//g, '\\');
    return fs.existsSync(winPath);
  } else if (process.platform === 'darwin') {
    return fs.existsSync(cmdPath);
  }
  return true; // on linux assume available in PATH
}

function readJsonSafe(filePath) {
  try {
    const raw = fs.readFileSync(filePath, 'utf-8').replace(/^\uFEFF/, '');
    return JSON.parse(raw);
  } catch {
    return null;
  }
}

function install() {
  printBanner();

  console.log(`${c.cyan}${c.bright}[ARTCRAFT] 1. Verificando diretórios do Antigravity...${c.reset}`);
  if (!fs.existsSync(geminiConfig)) {
    fs.mkdirSync(geminiConfig, { recursive: true });
    console.log(`  ${c.green}✔ Criado diretório de configuração: ${geminiConfig}${c.reset}`);
  } else {
    console.log(`  ${c.green}✔ Diretório de configuração encontrado: ${geminiConfig}${c.reset}`);
  }

  if (!fs.existsSync(skillsTargetDir)) {
    fs.mkdirSync(skillsTargetDir, { recursive: true });
    console.log(`  ${c.green}✔ Criado diretório de skills: ${skillsTargetDir}${c.reset}`);
  }

  console.log(`\n${c.cyan}${c.bright}[ARTCRAFT] 2. Instalando as 6 Skills da Suíte ArtCraft...${c.reset}`);
  let installedCount = 0;

  for (const skill of SKILL_NAMES) {
    let src = path.join(sourceSkillsDir, skill);
    if (!fs.existsSync(src)) {
      src = path.join(packageRoot, skill);
    }

    if (fs.existsSync(src)) {
      const dest = path.join(skillsTargetDir, skill);
      fs.cpSync(src, dest, { recursive: true, force: true });
      console.log(`  ${c.green}✔ Skill instalada:${c.reset} ${c.bright}${skill}${c.reset} -> ${dest}`);
      installedCount++;
    } else {
      console.log(`  ${c.yellow}⚠ Origem da skill não encontrada: ${skill}${c.reset}`);
    }
  }
  console.log(`  ${c.gray}Total de skills instaladas: ${installedCount}/${SKILL_NAMES.length}${c.reset}`);

  console.log(`\n${c.cyan}${c.bright}[ARTCRAFT] 3. Detectando e configurando servidores MCP dos Aplicativos...${c.reset}`);

  let configData = { mcpServers: {} };
  if (fs.existsSync(mcpConfigFile)) {
    const parsed = readJsonSafe(mcpConfigFile);
    if (parsed) {
      configData = parsed;
      if (!configData.mcpServers) configData.mcpServers = {};
      console.log(`  ${c.gray}Preservando servidores existentes em mcp_config.json${c.reset}`);
    } else {
      console.log(`  ${c.yellow}⚠ mcp_config.json existente não era JSON válido. Criando backup...${c.reset}`);
      fs.copyFileSync(mcpConfigFile, `${mcpConfigFile}.bak`);
      configData = { mcpServers: {} };
    }
  }

  let detectedApps = 0;
  for (const app of CRAFT_APPS) {
    const cmdPath = resolveCommandPath(app);
    const exists = checkAppExists(cmdPath);

    if (exists) {
      detectedApps++;
      console.log(`  ${c.green}✔ App detectado:${c.reset} ${app.id} (${cmdPath})`);
    } else {
      console.log(`  ${c.gray}• App configurado (não encontrado no caminho padrão): ${app.id}${c.reset}`);
    }

    configData.mcpServers[app.id] = {
      command: cmdPath,
      args: app.args,
    };
  }

  fs.writeFileSync(mcpConfigFile, JSON.stringify(configData, null, 2), 'utf-8');
  console.log(`  ${c.green}✔ Arquivo mcp_config.json atualizado com sucesso!${c.reset}`);

  console.log(`\n${c.green}${c.bright}=================================================================${c.reset}`);
  console.log(`${c.green}${c.bright}  INSTALAÇÃO CONCLUÍDA COM SUCESSO VIA NPM / NPX!${c.reset}`);
  console.log(`${c.green}${c.bright}=================================================================${c.reset}`);
  console.log(`  • Skills instaladas em: ${skillsTargetDir}`);
  console.log(`  • Configuração MCP salva em: ${mcpConfigFile}`);
  console.log(`  • Aplicativos detectados: ${detectedApps}/${CRAFT_APPS.length}`);
  console.log(`\n${c.cyan}${c.bright}Como usar no Antigravity:${c.reset}`);
  console.log(`  1. Abra um novo chat ou reinicie a sessão do Antigravity.`);
  console.log(`  2. Envie qualquer solicitação:`);
  console.log(`     ${c.yellow}"ArtCraft: Planeje uma campanha completa com vídeo, fotos e deck"${c.reset}`);
  console.log(`  3. Ou acione uma das skills diretamente:`);
  console.log(`     ${c.cyan}/artcraft-frontend, /artcraft-video, /artcraft-image, /artcraft-pitchdeck, /artcraft-sheet${c.reset}`);
  console.log(`${c.green}=================================================================${c.reset}\n`);
}

function status() {
  printBanner();
  console.log(`${c.cyan}${c.bright}[STATUS] Diagnóstico do Ambiente ArtCraft:${c.reset}\n`);

  console.log(`${c.bright}1. Skills Instaladas em ~/.gemini/config/skills:${c.reset}`);
  for (const skill of SKILL_NAMES) {
    const target = path.join(skillsTargetDir, skill);
    const exists = fs.existsSync(target);
    const mark = exists ? `${c.green}✔ Instalada${c.reset}` : `${c.red}✖ Ausente${c.reset}`;
    console.log(`  • ${skill.padEnd(20)}: ${mark}`);
  }

  console.log(`\n${c.bright}2. Aplicativos ArtCraft no Sistema:${c.reset}`);
  for (const app of CRAFT_APPS) {
    const cmdPath = resolveCommandPath(app);
    const exists = checkAppExists(cmdPath);
    const mark = exists ? `${c.green}✔ Detectado${c.reset}` : `${c.yellow}○ Não encontrado no caminho padrão${c.reset}`;
    console.log(`  • ${app.id.padEnd(14)}: ${mark} (${cmdPath})`);
  }

  console.log(`\n${c.bright}3. Configuração MCP (${mcpConfigFile}):${c.reset}`);
  if (fs.existsSync(mcpConfigFile)) {
    const data = readJsonSafe(mcpConfigFile);
    if (data) {
      const servers = Object.keys(data.mcpServers || {});
      console.log(`  • Servidores registrados: ${servers.join(', ') || 'Nenhum'}`);
    } else {
      console.log(`  ${c.red}✖ Erro ao ler mcp_config.json${c.reset}`);
    }
  } else {
    console.log(`  ${c.yellow}○ Arquivo mcp_config.json não existe.${c.reset}`);
  }
  console.log();
}

function uninstall() {
  printBanner();
  console.log(`${c.yellow}${c.bright}[DESINSTALAÇÃO] Removendo ArtCraft da máquina...${c.reset}\n`);

  for (const skill of SKILL_NAMES) {
    const target = path.join(skillsTargetDir, skill);
    if (fs.existsSync(target)) {
      fs.rmSync(target, { recursive: true, force: true });
      console.log(`  ${c.green}✔ Removida:${c.reset} ${skill}`);
    }
  }

  if (fs.existsSync(mcpConfigFile)) {
    const data = readJsonSafe(mcpConfigFile);
    if (data && data.mcpServers) {
      for (const app of CRAFT_APPS) {
        if (data.mcpServers[app.id]) {
          delete data.mcpServers[app.id];
          console.log(`  ${c.green}✔ Servidor MCP removido:${c.reset} ${app.id}`);
        }
      }
      fs.writeFileSync(mcpConfigFile, JSON.stringify(data, null, 2), 'utf-8');
    }
  }
  console.log(`\n${c.green}✔ Desinstalação concluída com sucesso.${c.reset}\n`);
}

function showHelp() {
  printBanner();
  console.log(`Uso:
  ${c.bright}npx artcraft-suite${c.reset} [comando]
  ${c.bright}pnpm dlx artcraft-suite${c.reset} [comando]

Comandos disponíveis:
  ${c.cyan}install${c.reset}      Instala todas as 6 skills e configura os servidores MCP (Padrão)
  ${c.cyan}status${c.reset}       Verifica status das skills instaladas e apps detectados
  ${c.cyan}uninstall${c.reset}    Remove as skills instaladas e limpa entradas MCP
  ${c.cyan}help${c.reset}         Exibe esta mensagem de ajuda

Exemplos:
  npx artcraft-suite
  npx artcraft-suite status
  pnpm dlx artcraft-suite install
`);
}

const arg = (process.argv[2] || 'install').toLowerCase();

switch (arg) {
  case 'install':
  case 'i':
    install();
    break;
  case 'status':
  case 'check':
    status();
    break;
  case 'uninstall':
  case 'remove':
    uninstall();
    break;
  case 'help':
  case '--help':
  case '-h':
    showHelp();
    break;
  default:
    console.log(`${c.red}Comando desconhecido: ${arg}${c.reset}\n`);
    showHelp();
    process.exit(1);
}
