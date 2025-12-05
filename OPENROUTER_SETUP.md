# Configuration OpenRouter API pour l'IA

Ce guide explique comment configurer OpenRouter API pour utiliser les fonctionnalités IA de l'application.

## Qu'est-ce qu'OpenRouter ?

OpenRouter est une API unifiée qui permet d'accéder à de nombreux modèles de langage (LLM) comme GPT-4, Claude, Llama, etc. sans avoir à gérer plusieurs API keys.

## Étapes de configuration

### 1. Créer un compte OpenRouter

1. Allez sur [https://openrouter.ai](https://openrouter.ai)
2. Créez un compte ou connectez-vous
3. Allez dans la section "Keys" de votre dashboard

### 2. Générer une clé API

1. Cliquez sur "Create Key"
2. Donnez un nom à votre clé (ex: "Mayan EDMS Production")
3. Copiez la clé API générée (elle ne sera affichée qu'une seule fois)

### 3. Configurer les variables d'environnement

Ajoutez les variables suivantes dans votre fichier `backend/.env` :

```env
# Configuration OpenRouter API
OPENROUTER_API_URL=https://openrouter.ai/api/v1
OPENROUTER_API_KEY=votre_cle_api_ici
OPENROUTER_MODEL=openai/gpt-4o-mini
OPENROUTER_HTTP_REFERER=http://localhost:5000
OPENROUTER_APP_NAME=Mayan EDMS

# Génération automatique de résumé IA lors de l'upload (true/false)
AUTO_GENERATE_AI_SUMMARY=false
```

### 4. Modèles disponibles

OpenRouter supporte de nombreux modèles. Voici quelques recommandations :

- **GPT-4o Mini** (recommandé pour le développement) : `openai/gpt-4o-mini`
- **GPT-4o** (meilleure qualité) : `openai/gpt-4o`
- **Claude 3.5 Sonnet** : `anthropic/claude-3.5-sonnet`
- **Llama 3.1 70B** : `meta-llama/llama-3.1-70b-instruct`

Consultez [https://openrouter.ai/models](https://openrouter.ai/models) pour la liste complète.

### 5. Coûts

Les coûts varient selon le modèle choisi :
- GPT-4o Mini : ~$0.15 / 1M tokens d'entrée, ~$0.60 / 1M tokens de sortie
- GPT-4o : ~$2.50 / 1M tokens d'entrée, ~$10.00 / 1M tokens de sortie

Pour un usage modéré, GPT-4o Mini est généralement suffisant et très économique.

## Fonctionnalités IA disponibles

### 1. Résumé de document
- Génère un résumé concis (3-5 phrases)
- Extrait 5-7 points clés
- Détecte la catégorie et la langue

**Endpoint:** `POST /api/ai/summarize`

### 2. Extraction d'entités
- Personnes mentionnées
- Organisations
- Dates importantes
- Lieux
- Montants financiers
- Mots-clés
- Thèmes principaux

**Endpoint:** `POST /api/ai/extract-entities`

### 3. Analyse de sentiment
- Sentiment général (positif/neutre/négatif)
- Ton du document
- Niveau de confiance
- Émotions détectées

**Endpoint:** `POST /api/ai/analyze-sentiment`

### 4. Analytics complètes
- Complexité du document
- Type et secteur
- Recommandations
- Risques identifiés
- Opportunités
- Prochaines étapes suggérées

**Endpoint:** `POST /api/ai/analytics`

### 5. Analyse complète
Génère toutes les analyses ci-dessus en une seule requête.

**Endpoint:** `POST /api/ai/complete-analysis`

### 6. Comparaison de documents
Compare deux documents et identifie similitudes et différences.

**Endpoint:** `POST /api/ai/compare`

### 7. Génération de tags automatiques
Génère 5-10 tags pertinents pour un document.

**Endpoint:** `POST /api/ai/generate-tags`

### 8. Analytics de projet
Statistiques agrégées pour un projet entier.

**Endpoint:** `GET /api/ai/project-analytics/:projectId`

## Utilisation

### Génération manuelle

Par défaut, la génération automatique de résumé est désactivée (`AUTO_GENERATE_AI_SUMMARY=false`). 

Pour générer une analyse :
1. Ouvrez un document
2. Cliquez sur "Générer le résumé" pour un résumé simple
3. Cliquez sur "Analyse complète" pour toutes les analyses

### Génération automatique

Pour activer la génération automatique lors de l'upload :
```env
AUTO_GENERATE_AI_SUMMARY=true
```

⚠️ **Attention:** Cela peut générer des coûts API importants si vous uploadez beaucoup de documents.

## Vérification de la configuration

Pour vérifier que OpenRouter est correctement configuré :

```bash
curl http://localhost:5000/api/ai/health
```

Réponse attendue :
```json
{
  "success": true,
  "available": true,
  "service": "OpenRouter API"
}
```

## Dépannage

### Erreur: "OPENROUTER_API_KEY non configuré"
- Vérifiez que la variable `OPENROUTER_API_KEY` est définie dans `backend/.env`
- Redémarrez le serveur après modification du `.env`

### Erreur: "Erreur OpenRouter API: ..."
- Vérifiez que votre clé API est valide
- Vérifiez que vous avez des crédits sur votre compte OpenRouter
- Consultez les logs du serveur pour plus de détails

### Les analyses ne se génèrent pas
- Vérifiez que le texte peut être extrait du document (PDF, Word, Excel supportés)
- Vérifiez les logs du serveur pour les erreurs
- Assurez-vous que le document contient du texte (pas seulement des images)

## Sécurité

- ⚠️ **Ne commitez JAMAIS votre clé API dans Git**
- Utilisez des variables d'environnement
- Limitez les permissions de votre clé API dans OpenRouter
- Surveillez votre utilisation pour éviter les coûts inattendus

## Support

Pour plus d'informations :
- Documentation OpenRouter: [https://openrouter.ai/docs](https://openrouter.ai/docs)
- Dashboard OpenRouter: [https://openrouter.ai/keys](https://openrouter.ai/keys)
