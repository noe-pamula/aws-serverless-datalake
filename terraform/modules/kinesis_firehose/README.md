# 📥 Envoi de Messages à Kinesis Data Firehose via AWS CLI

Ce guide explique comment envoyer des messages à un flux Kinesis Data Firehose en utilisant AWS CLI.

## 🛠 Prérequis

- AWS CLI installé et configuré avec les bonnes permissions.
- Un flux Kinesis Data Firehose configuré (comme défini dans les modules Terraform).

## 🚀 Envoyer un Message à Kinesis Data Firehose

Pour envoyer un message à Kinesis Data Firehose, utilise la commande suivante :

### Commande CLI

```bash
aws firehose put-record \
  --delivery-stream-name <firehose_name> \
  --record='{"Data":"Your message or data here\n"}'
```

#### Exemples

1. Envoyer un message simple :

```bash
aws firehose put-record \
  --delivery-stream-name talosi-firehose-stream \
  --record='{"Data":"Hello, this is a test message\n"}'
```

2. Envoyer des données JSON :
(uniquement dans un bash -> powershel :/)

```bash
aws firehose put-record --delivery-stream-name talosi-firehose-stream --cli-binary-format raw-in-base64-out --record='{"Data":"{\"name\":\"talosi\",\"domain\":\"it\"}"}'
```

#### Notes

- **Format des Données :** Les données doivent être encodées en base64 par la CLI avant d'être envoyées à Firehose. La CLI AWS gère automatiquement cet - encodage lorsque tu utilises le format JSON comme montré ci-dessus.
- **Limite de Taille :** Chaque enregistrement envoyé à Firehose ne doit pas dépasser 1 000 Ko.
- **Configuration du Flux :** Assure-toi que le flux Kinesis Firehose est configuré pour accepter les messages dans le format souhaité et que le rôle IAM associé dispose des permissions nécessaires pour écrire dans le bucket S3.

### 🔍 Vérification
Après avoir envoyé les messages, vérifie que les données sont correctement livrées dans le bucket S3 configuré avec Firehose.

1. Lister les Objets dans S3 :

```bash
aws s3 ls s3://<bucket_name>/
```

2. Télécharger un Objet pour Vérification :

```bash
aws s3 cp s3://<bucket_name>/<object_key> .
```