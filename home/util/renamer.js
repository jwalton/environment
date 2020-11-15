#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const EPISODE_RE = /^(.*)[\s\.-]+[sS]?(\d+)[XxEe](\d+)[\s\.-]+(.*)([\s\.-]\d+p.*)$/;
const PWD = process.cwd();
const DRY_RUN = false;

function transform(filename) {
    const ext = path.extname(filename);
    const baseFilename = path.basename(filename, ext);

    const match = EPISODE_RE.exec(baseFilename);
    if (match) {
        season = parseInt(match[2], 10).toString().padStart(2, '0');
        episode = parseInt(match[3], 10).toString().padStart(2, '0');
        title = match[4].replace(/\./g, ' ');
        return `s${season}e${episode} - ${title}${ext}`;
    } else {
        return undefined;
    }
}

const files = fs.readdirSync(PWD);
files.forEach(file => {
    const resolvedFile = path.resolve(PWD, file);

    const renamed = transform(file);
    if (!renamed) {
        console.log(`File ${file} did not match`);
        return;
    }

    const resolvedRenamed = path.resolve(PWD, renamed);
    if (resolvedRenamed === resolvedFile) {
        console.log(`Skipping ${file}`);
        return;
    }

    if (fs.existsSync(resolvedRenamed)) {
        throw new Error(`File exists ${renamed}`);
    }

    console.log(`Renaming "${file}" to "${renamed}"`);
    if (!DRY_RUN) {
        fs.renameSync(resolvedFile, resolvedRenamed);
    }
});

