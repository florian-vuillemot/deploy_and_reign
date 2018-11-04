# Projet d'introduction à l'administration système {EPITECH}

## But :
Le but de ce projet est de déployer un parc de machines et de les administrers à distance.

### Demandes du projet :
1. Création d'un ISO avec 
   * Un Windows 10
     * Office 365
     * Rendre inutilisable l'utilisation de clés USB
   * Un Fedora
     * Emacs
     * Fluxbox
2. Un logiciel d'administration à distance des machines pour
   * Mettre à jour les packets et le système
   * Installer des logiciels
  
## Création de l'ISO

### Avant de commencer
* Installer Virtualbox (https://www.virtualbox.org/)
* Télécharger une image Windows 10 (https://www.microsoft.com/fr-fr/software-download/windows10)
* Télécharger une image de Fedora Worksation (https://getfedora.org/fr/workstation/download/)
* Télécharger un ISO Clonezilla (https://clonezilla.org/downloads.php)

### Création du dualboot
1. Lancer Virtualbox
2. Créer une machine virtuel
3. Lancer la machine virtuel avec l'ISO Windows 10. ** Attention ** Vous devez partitionner le disque durrant l'installation pour pouvoir installer le Fedora
4. Une fois l'installation de Windows 10 terminé éteigner la machine
5. Dans Virtualbox, changer le disque de lancement de votre machine virtuel pour sélectionner l'ISO Fedora (Partie "Figure 6.8. Virtual Machine Added" de la documentation https://docs.oracle.com/cd/E26217_01/E26796/html/qs-create-vm.html)
6. Lancer la machine et faite l'installation de Fedora sur la partition précèdement créer sans écraser la partion Windows 10. Le Grub s'installe automatiquement
7. Une fois l'installation et la configuration de votre Fedora faite vous pouvez éteindre la machine

### Etât des lieux
Vous avez un ISO avec un Fedora et un Windows 10 installé. Vous pouvez accèder au système d'exploitation que vous souhaitez lors du démarrage de votre machine grâce au GRUB installer lors de l'installation de votre Fedora.

### A prèsent vous devez installer les logiciels business demandés
Sur Windows il vous suffit d'aller sur le site d'Office 365 (https://support.office.com/fr-fr/article/t%C3%A9l%C3%A9charger-et-installer-ou-r%C3%A9installer-office-365-ou-office-2019-sur-un-pc-ou-mac-4414eaaf-0478-48be-9c42-23adc4716658)
Sur Fedora allez ouvrez un terminal et faite:
- `sudo dnf install emacs`
- `sudo dnf install fluxbox`

### Désactivation des clés USB sur Windows
Vous avez plusieurs méthode pour effectuer cette tâche. Personnelement j'ai appliqué une restriction via les Groupe Policy. Vous trouverez la procédure compléte sur https://www.isumsoft.com/windows-10/how-to-disable-use-of-usb-storage-devices-in-windows-10.html.

### Maintenant passons à l'installation des agents pour l'administration distante des machines
Ici nous avons choisi d'utiliser Salstack. C'est un équivalent de Puppet ou Ansible.
Pourquoi avoir choisi Salstack ?
- Documentation et exemple très nombreux
- Utilisation extrèmenet simple (en 10 min vous pouvez éxécuter des commandes sur des machines distante)
- Les extensions sont écrite en Python

__Note:__ Avant de choisir un POC fut effectuer avec Puppet avant de choisir Salstack comme outil.

#### Brève explication de Salstack
Salstack se compose de 2 binaires :
- Minion: Client qui va éxécuter les opérations sur la machine hôte
- Master: Qui va envoyer les commandes à éxécuters aux minions

### Nous allons installer un minion sur le Windows et sur le Linux. Grâce à cela nous pourrons effectuer des opérations distantes sur les deux systèmes d'opération
- Sur Windows, l'installation se fait via le liens suivant https://docs.saltstack.com/en/latest/topics/installation/windows.html. Choisissez de préférence la version 3 de Python. Lors de l'installation l'URL du master sera demandé. Si vous n'en possèdez pas encore ce n'est pas grâve car vous pourrez le modifier ultérieurement grâce au fichier de configuration de votre minion.
- Sur Fedora, il vous suffit de faire un `sudo dnf install salt-minion`. Si cela ne fonctionne pas allez sur la documentation suivante https://docs.saltstack.com/en/latest/topics/installation/fedora.html. Vous devez modifier l'URL de votre master via un fichier de configuration (https://docs.saltstack.com/en/latest/ref/configuration/minion.html).

Une fois qu'un minion est installé et configurer il essait de se connecter à sont master. Il se peut que vous devez re démarrer votre machine pour qu'il se connecte.
Sur votre master éxécuter la commande `salt '*' test.ping` pour vérifier l'ajout d'un minion. 

__Note:__ Il se peux que votre minion soit présent, allumé mais que le ping echou. N'hésitez pas à changer la valeur de timeout avec l'option `--timeout=60` ou 60 est le nombre de seconds avant le timeout.


## Une fois que vos minion sont configuré avec votre master vous êtes près pour créer vos ISO et le partager sur votre parc

### Les étapes à suivre
1. Lancer Virtualbox
2. Comme pour Fedora, changer le disque de démarrage pour mettre l'ISO de Clonezilla.
3. Lancer la machine
4. Une fois que vous avez booter sur Clonezilla suivez les instructions à l'écran. Dans l'ensemble il vous suffit de faire next.
Je ne vais pas rentrer dans les détailles concernant la création de la sauvegarde grâce à Clonezilla. Vous trouverez une grande documentation sur le Web. Pour ma part je n'ai pas utilisé de clée USB mais un server ssh pour stocker la sauvegarde.

Maintenant que vous avez votre image vous pouvez relancer une machine virtuelle avec à nouveau Clonezilla comme disque de lancement.
Une fois votre machine lancé il faut sélectionner "Little server" et suivre les instructions. 

__Note:__ dans mon exemple j'ai choisie d'utiliser un serveur en mode multicast.
Après cela, créer une dernière machine virtuelle avec comme disque de lancement Clonezilla (comme précédement) mais cette fois sélectionner "Little client" puis entrer l'addresse IP de votre "Little server" créer dans l'étape précédente. Suivez les instructions et sauvegarde sera restoré !

__Note:__ Lors de la configuration de votre "Little client" n'oubliez pas de créer une machine avec un disque dur supérieur ou égale au disque de votre machine sauvegardé.

That's done ! Vous avez déployé une nouvelle machine sur votre parc. Vous pouvez l'administré à distance avec votre agent Salstack.

Afin de simplifier votre d'administrateur vous trouvez des fichiers de configuration pour votre Salt-master. Ils doivent être déposé dans le dossier "/srv/salt/". Vous pouvez les éxécuters en faisant : `salt '*' state.apply nom_du_fichier`. 
Note: Le nom du fichier et sans son extension 'sls'.

