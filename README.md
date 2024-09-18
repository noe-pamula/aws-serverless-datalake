# 📊 Data Lake on AWS with Terraform and Python

## Description

Ce dépôt contient l'infrastructure et les scripts nécessaires pour déployer un Data Lake sur AWS en utilisant Terraform et Python. L'objectif est de fournir une solution complète pour la gestion de données à grande échelle, incluant le stockage, l'acquisition, le traitement et le partage des données à partir d'un Data Lake sur AWS.

## 🛠️ Technologies Utilisées

- **Terraform** : Pour l'automatisation de l'infrastructure cloud, y compris la création de buckets S3, de rôles IAM, et de services comme AWS Kinesis, AWS Glue, et AWS Lake Formation.
- **Python** : Pour les scripts de traitement des données, les ETL (Extract, Transform, Load) et les automatisations supplémentaires.
- **AWS Services** : Utilisation d'Amazon S3, Amazon Kinesis, Amazon Athena, AWS Lake Formation, et autres pour construire un Data Lake scalable et sécurisé.

## 📋 Fonctionnalités

- **Infrastructure as Code (IaC)** : Utilisation de Terraform pour déployer et gérer l'infrastructure AWS de manière reproductible et versionnée.
- **Acquisition de Données** : Ingestion de données en temps réel et par lots via AWS Kinesis et AWS Glue.
- **Traitement des Données** : Pipelines de transformation des données avec AWS Glue et scripts Python.
- **Partage des Données** : Exposition des données via Amazon Athena, API Gateway, et intégration avec AWS Lake Formation pour la gouvernance et la gestion des accès.
- **Gouvernance et Sécurité** : Mise en place de rôles IAM et de stratégies de sécurité pour protéger les données sensibles et gérer les accès.

## 🚀 Getting Started

1. **Prérequis :**
   - Installer [Terraform](https://www.terraform.io/downloads).
   - Configurer AWS CLI avec les bonnes permissions.
   - Python 3.x avec les bibliothèques nécessaires (`boto3`, `pandas`, etc.).

2. **Déploiement de l'Infrastructure :**
   - Cloner le dépôt : `git clone git@github.com:noe-pamula/aws-serverless-datalake.git`
   - Initialiser Terraform : `terraform init`
   - Planifier les changements : `terraform plan`
   - Appliquer les changements : `terraform apply`

3. **Exécution des Scripts Python :**
   - Naviguer dans le dossier `scripts` pour les ETL et les transformations de données.
   - Exécuter les scripts selon les besoins : `python script_name.py`

## 📂 Structure du Répertoire

- `terraform/` : Contient les fichiers de configuration Terraform pour déployer l'infrastructure AWS.
- `scripts/` : Scripts Python pour l'acquisition et le traitement des données.
- `docs/` : Documentation additionnelle sur le Data Lake, l'architecture, et les configurations.

## 📄 Documentation

Pour plus d'informations sur la configuration et l'utilisation du Data Lake, consultez la documentation dans le dossier `docs` ou les Wiki du projet.

## 🤝 Contribuer

Les contributions sont les bienvenues ! Merci de soumettre des pull requests pour des améliorations ou des corrections de bugs, ou d'ouvrir des issues pour des suggestions.

## 📧 Contact

Pour toute question ou suggestion, merci de contacter noe@talosi.com .
