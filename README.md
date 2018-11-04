# Projet d'introduction à l'administration système {EPITECH}

## But :
Le but de ce projet est de déployer un parc de machines et de les administrers à distance.

Demandes du projet :
1. Création d'un ISO avec 
   * Un Windows 10
     * Office 365
   * Un Fedora
     * Emacs
     * Fluxbox
2. Un logiciel d'administration à distance des machines pour
   * Mettre à jour les packets et le système
   * Installer des logiciels
  
## Création de l'ISO

Avant de commencer
* Installer Virtualbox (https://www.virtualbox.org/)
* Télécharger une image Windows 10 (https://www.microsoft.com/fr-fr/software-download/windows10)
* Télécharger une image de Fedora Worksation (https://getfedora.org/fr/workstation/download/)
* Télécharger un ISO Clonezilla (https://clonezilla.org/downloads.php)

Création du dualboot
1. Lancer Virtualbox
2. Créer une machine virtuel
3. Lancer la machine virtuel avec l'ISO Windows 10. ** Attention ** Vous devez partitionner le disque durrant l'installation pour pouvoir installer le Fedora
4. Une fois l'installation de Windows 10 terminé éteigner la machine
5. Dans Virtualbox, changer le disque de lancement de votre machine virtuel pour sélectionner l'ISO Fedora (Partie "Figure 6.8. Virtual Machine Added" de la documentation https://docs.oracle.com/cd/E26217_01/E26796/html/qs-create-vm.html)
6. Lancer la machine et faite l'installation de Fedora sur la partition précèdement créer sans écraser la partion Windows 10. Le Grub s'installe automatiquement
7. Une fois l'installation et la configuration de votre Fedora faite vous pouvez éteindre la machine

Etât des lieux
Vous avez un ISO avec un Fedora et un Windows 10 installé. Vous pouvez accèder au système d'exploitation que vous souhaitez lors du démarrage de votre machine grâce au GRUB installer lors de l'installation de votre Fedora.

A prèsent vous devez installer les logiciels business demandés
Sur Windows il vous suffit d'aller sur le site d'Office 365 (https://support.office.com/fr-fr/article/t%C3%A9l%C3%A9charger-et-installer-ou-r%C3%A9installer-office-365-ou-office-2019-sur-un-pc-ou-mac-4414eaaf-0478-48be-9c42-23adc4716658)
Sur Fedora allez ouvrez un terminal et faite:
- `sudo dnf install emacs`
- `sudo dnf install fluxbox`

Maintenant passons à l'installation des agents pour l'administration distante des machines.
Ici nous avons choisi d'utiliser Salstack. C'est un équivalent de Puppet ou Ansible.
Pourquoi avoir choisi Salstack ?
- Documentation et exemple très nombreux
- Utilisation extrèmenet simple (en 10 min vous pouvez éxécuter des commandes sur des machines distante)
- Les extensions sont écrite en Python

Avant de choisir un POC fut effectuer avec Puppet avant de choisir Salstack comme outil.

