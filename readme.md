# Backup script
Let's consider you have 4 drives (about 2 TB each):

- Live drive (`P:\`) (where you store whatever you want)
- Active Backup drive (`Q:\`) (daily/weekly backup of your stuff)
- Offsite 1 (next to the machine, but not connected to the computer)
- Offsite 2 (outside, not connected. Maybe at work or at a safe place)

The do-backup.cmd script allow you to create an archive of your files quickly. (More than 240 GB in about one hour) Make sure the drive are connected through USB 3.0 port for maximum speed and file system is NTFS. Make sure to set the BACKUP_KEY environment variable to a complex password and keep the password on an external support. You may want to change the backup rotation strategy. (removing backups older than 60 days)

The script focus on speed and security. The script use lot of space. Space is cheap some people would say.

The goal of this project is to suggest a backup strategy. Everything remain on your own infrastructure. (no need to use cloud storage) The Live drive gives you quick access to your files. The Active Backup allow you to setup automatic backup (daily/weekly). The two Offsite drives allow you to keep at any given time a backup outside of your house. (case of natural disaster and keep one drive completly disconnected from any machine)

Note: Currently, it does work only on Windows. A similar logic could be reuse for other platforms.

# Copyright and license
Code released under the MIT license.