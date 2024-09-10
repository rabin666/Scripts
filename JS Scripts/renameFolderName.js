// This script renames all the folders in the directory to replace the number after 'officeconverter202425-' with '11111' 

// Written when I need to rename the folder name of the office-converter temp files with active PID in between.


const fs = require("fs");
const path = require("path");

// Assuming 'folderPath' is the path to the directory containing the folders
// const folderPath = "/path/to/your/folders";
const folderPath = "./";

// Read the current directory
fs.readdir(folderPath, (err, files) => {
    if (err) {
        console.error("Error reading the directory", err);
        return;
    }

    files.forEach((file) => {
    // Check if it's a directory
        const fullPath = path.join(folderPath, file);
        fs.stat(fullPath, (err, stats) => {
            if (err) {
                console.error("Error retrieving file stats", err);
                return;
            }

            if (stats.isDirectory()) {
                // Apply the regex to the folder name and rename it
                // Correct pattern to replace only the number after 'officeconverter202425-' and before the second dash
                const newFolderName = file.replace(/(officeconverter202425-)\d+(-.*)/, "$11111$2");
                const newFullPath = path.join(folderPath, newFolderName);

                fs.rename(fullPath, newFullPath, (err) => {
                    if (err) {
                        console.error(`Error renaming folder from ${fullPath} to ${newFullPath}`, err);
                    } else {
                        console.log(`Folder renamed from ${fullPath} to ${newFullPath}`);
                    }
                });
            }
        });
    });
});
