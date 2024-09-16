# 📤 Envoi de Fichiers CSV dans le Bucket S3 via AWS CLI

Ce guide explique comment envoyer un fichier CSV dans le bucket S3 de ton Data Lake en utilisant AWS CLI.

## 🛠 Prérequis

- AWS CLI installé et configuré avec les bonnes permissions.
- Un bucket S3 configuré (comme défini dans les modules Terraform).

## 🚀 Envoyer un Fichier CSV à S3

Pour envoyer un fichier CSV à S3, utilise la commande suivante :

### Commande CLI

```bash
aws s3 cp <local_csv_file_path> s3://<bucket_name>/<destination_path_in_bucket>
```

### Exemples

1. **Envoyer un fichier CSV à la racine du bucket :**

```bash
aws s3 cp ./data/sample.csv s3://talosi-datalake-serverless/
```

2. **Envoyer un fichier CSV dans un dossier spécifique du bucket :**

```bash
aws s3 cp ./data/sample.csv s3://talosi-datalake-serverless/csv_files/
```

### Notes

- **Chemin du Fichier Local :** Assure-toi que le chemin du fichier local (`<local_csv_file_path>`) est correct.
- **Bucket et Chemin de Destination :** Remplace `<bucket_name>` et `<destination_path_in_bucket>` par le nom de ton bucket et le chemin de destination souhaité.
- **Permissions :** Assure-toi que le rôle IAM associé à ton utilisateur CLI dispose des permissions nécessaires pour effectuer l'opération `s3:PutObject` sur le bucket.
- **Vérification :** Après l'envoi, tu peux vérifier que le fichier a été correctement uploadé en listant les objets du bucket :

```bash
aws s3 ls s3://talosi-datalake-serverless/
```
