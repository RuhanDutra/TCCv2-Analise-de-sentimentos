# Usar uma imagem base do Python
FROM python:3.11-slim

# Definir o diretório de trabalho
WORKDIR /api

# Copiar o arquivo requirements.txt e instalar as dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN python -m spacy download pt_core_news_sm

# Copiar todo o código da aplicação para o diretório de trabalho
COPY . .

# Expor a porta da API
EXPOSE 5000

# Comando para executar o Flask
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
# CMD ["python", "app.py"]
