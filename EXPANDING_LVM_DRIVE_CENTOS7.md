This is just to list out what I had to do in order to expand my hard drive space for my CentOS server after adding in a completely new HD. Note that there may have been things done before/in the middle/after that I may have forgotten to document.

1. Find out what device is the new hard drive. It should be "obvious" with the use of `lsblk`:

   ```
   $ lsblk
   NAME            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
   sda               8:0    0   2T  0 disk
   └─sda1            8:1    0   2T  0 part
     └─centos-home 253:2    0    4T  0 lvm  /home
   sdb               8:16   0   2T  0 disk
   sdc               8:32   0 8G  0 disk
   └─sdc1            8:33   0 8G  0 part
     ├─centos-root 253:0    0    50G  0 lvm  /
     └─centos-home 253:2    0    4T  0 lvm  /home
   ```

   Note that `sdb` (`/dev/sdb`)  is the physical volume (PV) I'm trying to add + *has no partitions*. I can't remember the 'type' but it was probably `disk`.

2. Wipe the disk:

   ```
   $ wipefs -a /dev/sdb
   ```

3. Create the physical volume for use by VM:
   ```
   $ pvcreate /dev/sdb
   ```

4. Now, find out what logical volume you want to expand it on. Mine was 'home':
   ```
   $ lvdisplay
   ...
   --- Logical volume ---
   LV Path                /dev/centos/home
   LV Name                home
   VG Name                centos
   ...
   ```

5. Add the physical volume to the volume group (VG):
   ```
   $ vgextend home /dev/sdb
   ```

6. Expand the logical volume now by however much you want (I want all of it):
   ```
   $ lvextend -l +100%FREE /dev/centos/home
   ```
   
7. Finally, CentOS 7 seems to use xfs by default. So you have to use xfs_growfs (and not resize2fs, which seems to be for Fedora):

   ```
   $ xfs_growfs /dev/centos/home
   ```

And that's it! You can verify it however you want.
