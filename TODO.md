# TODO

- [x] Use git's submodules for the iptables scripts : https://github.com/jeremiedecock/iptables-scripts
- [ ] Rename all scripts pi_... without the .sh suffix
- [ ] Network: let choose dynamic IP or static IP (+ which address)
- [ ] Camera module
- [ ] Spi
- [ ] Mem split
- [ ] Sudo: secure /etc/sudoers and remove /etc/sudoers.d/01_pi_nopasswd -> "pi" user should not have root privileges!
- [ ] Vim
- [ ] Ipython config
- [ ] Screenrc
- [ ] Bashrc
- [ ] Iptables: let choose allowed 
    1. Would you like to enable and configure the Linux firewall for IPv4
        - If yes, goto 2
        - If no, quit
    2. Would you like to allow this computer to ~communicate~ on networks (if no, ...)
        - If yes, goto 3
        - If no, forbid all inputs and outputs for IPv4 and IPv6 then quit

    3. Would you ... all output ports ?
        - If yes, allow all outputs then goto 7
        - If no, goto 4
    4. Which ports should be open (output) ? then goto 5
    5. Would you ... all output ip dest ?
        - If yes, allow all outputs then goto 7
        - If no, goto 6
    6. Which dest IP should be open (output) ? then goto 7

    7. Would you ... all input ports ?
        - If yes, allow all input then quit
        - If no, goto 8
    8. Which port should be open (input) ? then goto 9
    9. Would you ... all input ip dest ?
        - If yes, allow all outputs then quit
        - If no, goto 10
    10. Which dest IP should be open (input) ? then quit
    - when quit, print the firewall rules and ask for confirmation
    - TODO: the same thing for IPv6...
- [ ] Tcpwrappers: almost the same questions than iptables...
- [ ] Resize -> 2 steps:
    - [ ] Localization/internationalization + resize partition then QUIT AND
          REBOOT (at least print a message and quit) "Would you like to reboot
          now ?" -> ajouter script dans /init.d/start (ac les étapes déjà
          validées)...
    - [ ] Automatically resume the script after reboot...
    - [ ] Mémoriser les opérations déjà menées jusqu'au bout et changer les
          résponses par défaut en conséquence (skip par défaut si l'opération a
          déjà été effectuée)
          dans /etc/pi.conf par ex
    - [ ] Utiliser des variables shell pour ça... et les enregistrer dans un
          fichier (faire une fonction "quit" appelé quand on choisi "q" ou à la
          fin du script et faire une fonction "init")

- [ ] Distribute scripts within a Debian package
- [ ] Rename the project "linux_post_install_scripts" and let it be usable for
      other systems than Raspbian (e.g. Debian, Slakeware, Gentoo, ...)
- [ ] Package list: les "groupes de packages" existent déja dans Debian,
      reutiliser le mécanisme existant plutot que de reinventer la roue...
      (tasksel ou un truc dans ce genre)
- [ ] Ajouter des serveurs de synchronisation dans le fichier /etc/ntp.conf ?
      Voici la liste des serveurs configurés par défaut :
      server 0.debian.pool.ntp.org iburst dynamic
      server 1.debian.pool.ntp.org iburst dynamic
      server 2.debian.pool.ntp.org iburst dynamic
      server 3.debian.pool.ntp.org iburst dynamic

