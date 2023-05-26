# SimpleLibrary
SimpleLibrary est une application bureautique qui permet de gérer une bibliothèque pour les écoles.
Cette application a été développée en langage C# et le Framework WPF pour un cours de programmation donné à l'ESA (École Supérieur des Affaires) à Namur.

Ce fichier README.md (MarkDown) explique comment installer l'application sur votre ordinateur.
Note : l'application n'est pas distribuée et contient donc la solution du projet, ouvrable dans VisualStudio.

Les différentes versions des programmes utilisés pour son développement :
- `SQL Server 2019`
- `SQL Server Management Studio 18`
- `Framework .NET 6.0`
- `VisualStudio 2022 (17.4.3)`

## Contenu du fichier MERCIER_SimpleLibrary.zip
contenu...

## Marche à suivre
Suivez ces étapes pour pouvoir lancer la solution dans VisualStudio.
Choisissez un endroit sur votre ordinateur et dézipper le fichier `MERCIER_SimpleLibrary.zip`.

#### Base de données
1) Ouvrez `SQL Server Management` et créez une nouvelle base de données (par exemple `SimpleLibrary`).
2) Exécutez une nouvelle query en reprenant le contenu du fichier `SimpleLibraryBackup.sql`
3) Fermez `SQL Server Management`.

#### appsettings.json

1) Copiez le contenu du dossier `SimpleLibraryRessources` dans un nouveau répertoire sur votre ordinateur (par exemple `Documents\SimpleLibraryRessources`).
2) Ouvrez les fichiers appsettings.json (dossier `WpfApp` et `BU`) et adaptez leur contenu en fonction de votre environnement.
```txt
"Server=.\\PGBDSQLSERVEUR;Database=SimpleLibrary;Trusted_Connection=True;Encrypt=False"
```
>Remplacez `.\\PGBDSQLSERVEUR` par le nom de votre instance SqlServer.
>Remplacez `SimpleLibrary` par le nom de votre base de données SqlServer.
---
```txt
"LogFilePath": "D:\\SimpleLibraryRessources\\util\\Logs\\simpleLogs.txt",
"CoverFolderPath": "D:\\SimpleLibraryRessources\\Covers\\",
```
>Remplacer `D:\\SimpleLibraryRessources` pour le `LogFilePath` et `CoverFolderPath` par le chemin de votre dossier créer plus tôt.

4) Sauvegarder les deux fichiers.

