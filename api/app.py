from flask import Flask, request, jsonify
from transformers import pipeline
from sklearn.feature_extraction.text import TfidfVectorizer
from nltk.corpus import stopwords
import nltk
import spacy

# Inicializar o Flask
app = Flask(__name__)

# Baixar stop words em português
nltk.download('stopwords')
stop_words_pt = stopwords.words('portuguese')

# Inicializar o pipeline de análise de sentimentos em português
sentiment_analysis = pipeline("sentiment-analysis", model="nlptown/bert-base-multilingual-uncased-sentiment")

# Carregar o modelo de linguagem em português do Spacy
nlp = spacy.load("pt_core_news_sm")

def analisar_sentimentos(avaliacoes):
    sentimentos = {'positivos': [], 'negativos': [], 'neutros': []}
    
    for avaliacao, produto_id, descricao in avaliacoes:
        resultado = sentiment_analysis(avaliacao)[0]
        label = resultado['label']
        
        if "5" in label or "4" in label:
            sentimentos['positivos'].append({'avaliacao': avaliacao, 'produto_id': produto_id, 'descricao': descricao})
        elif "1" in label or "2" in label:
            sentimentos['negativos'].append({'avaliacao': avaliacao, 'produto_id': produto_id, 'descricao': descricao})
        else:
            sentimentos['neutros'].append({'avaliacao': avaliacao, 'produto_id': produto_id, 'descricao': descricao})
    
    return sentimentos

def extrair_principais_termos(sentimentos):
    elogios = " ".join([item['avaliacao'] for item in sentimentos['positivos']]).strip()
    criticas = " ".join([item['avaliacao'] for item in sentimentos['negativos']]).strip()

    def filtrar_verbos(termos):
        termos_filtrados = []
        for termo in termos:
            doc = nlp(termo)
            substantivos_adjetivos = [token.text for token in doc if token.pos_ in ['NOUN', 'ADJ']]
            termos_filtrados.extend(substantivos_adjetivos)
        return termos_filtrados

    if elogios:
        vectorizer_elogios = TfidfVectorizer(max_features=10, stop_words=stop_words_pt)
        vectorizer_elogios.fit([elogios])
        principais_elogios = vectorizer_elogios.get_feature_names_out()
        principais_elogios = filtrar_verbos(principais_elogios)
    else:
        principais_elogios = []

    if criticas:
        vectorizer_criticas = TfidfVectorizer(max_features=10, stop_words=stop_words_pt)
        vectorizer_criticas.fit([criticas])
        principais_criticas = vectorizer_criticas.get_feature_names_out()
        principais_criticas = filtrar_verbos(principais_criticas)
    else:
        principais_criticas = []

    return principais_elogios, principais_criticas

@app.route('/analisar', methods=['POST'])
def analisar_avaliacoes():
    data = request.get_json()
    avaliacoes = data.get('avaliacoes', [])

    if not avaliacoes:
        return jsonify({'error': 'Nenhuma avaliação fornecida.'}), 400

    # Analisar sentimentos e extrair termos
    sentimentos = analisar_sentimentos(avaliacoes)
    elogios, criticas = extrair_principais_termos(sentimentos)

    return jsonify({
        'sentimentos': sentimentos,
        'principais_elogios': elogios,
        'principais_criticas': criticas
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
