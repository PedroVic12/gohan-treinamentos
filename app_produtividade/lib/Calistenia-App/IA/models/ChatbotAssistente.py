
import pyttsx3
import pandas as pd
import speech_recognition as sr
import textwrap
from IPython.display import Markdown
from IPython.display import display
import google.generativeai as genai
import PIL
import os
os.environ['GEMINI_KEY'] = "AIzaSyAPAFeexSmww1GOHMAQ0fWsHqoSlIppnDI"
GEMINI_KEY = "AIzaSyAPAFeexSmww1GOHMAQ0fWsHqoSlIppnDI"


genai.configure(api_key=GEMINI_KEY)


class C3PoAssisstente:
    def __init__(self):
        pass

    def to_markdown(self, text):
        text = text.replace('•', '  *')
        return Markdown(textwrap.indent(text, '> ', predicate=lambda _: True))

    def modeloTextoGenerativo(self, txt):
        model_TextGenerator = genai.GenerativeModel('gemini-pro')
        response = model_TextGenerator.generate_content('txt')
        return response.text

    def modeloVisaoComputacional(self, img_path, prompt_cliente):
        model_VisaoComputacional = genai.GenerativeModel('gemini-pro-vision')

        imagem = PIL.Image.open(img_path)
        print(imagem)

        response = model_VisaoComputacional.generate_content(imagem)
        # print('IMG= ', response.text)
        response_prompt = model_VisaoComputacional.generate_content(
            [prompt_cliente, imagem])
        result = response_prompt.resolve()
        return response.text

    def gerarDataFrame(self, img_path, prompt_cliente):
        texto_gerado = self.modeloVisaoComputacional(img_path, prompt_cliente)
        df = pd.DataFrame([texto_gerado])
        return df

#! Métodos de manipulação de texto
    def create_dataframe(self, _nome_coluna, results):
        """
            Cria um DataFrame do pandas para visualizar os resultados dos métodos de NLP.

            Args:
            results (dict): Um dicionário de resultados de NLP. 
                            Cada chave deve ser o nome de um método e o valor deve ser o resultado desse método.

            Returns:
            DataFrame: Um DataFrame do pandas visualizando os resultados dos métodos de NLP.
            """
        return pd.DataFrame.from_dict(results, orient='index', columns=[_nome_coluna])

    def processarTextoGerado(self, texto_gerado):
        # Aqui você processaria o texto gerado e extrairia informações relevantes
        # Por exemplo, se o texto contém informações estruturadas, você as extrairia aqui
        # Este é um exemplo, ajuste conforme necessário
        informacoes = {"Texto Gerado": texto_gerado}
        return informacoes


class ChatbotAssistente(C3PoAssisstente):
    def __init__(self):
        super().__init__()
        self.engine = pyttsx3.init()
        self.voices = self.engine.getProperty('voices')
        self.engine.setProperty('rate', 170)
        self.r = sr.Recognizer()
        self.mic = sr.Microphone()

    def configurar_voz(self, voz_index=1):
        self.engine.setProperty('voice', self.voices[voz_index].id)

    def ouvir_comando(self):
        with self.mic as fonte:
            self.r.adjust_for_ambient_noise(fonte)
            audio = self.r.listen(fonte)
            try:
                texto = self.r.recognize_google(audio, language="pt-BR")
                return texto
            except sr.UnknownValueError:
                return "Não entendi o que você disse."
            except sr.RequestError as e:
                return f"Erro ao solicitar resultados; {e}"

    def falar_resposta(self, resposta):
        self.engine.say(resposta)
        self.engine.runAndWait()

    def iniciar_chatbot(self):
        bem_vindo = "# Bem Vindo, eu sou o Gemini #"
        print("\n" + len(bem_vindo) * "#" + "\n" + bem_vindo + "\n" +
              len(bem_vindo) * "#" + "\n###   Digite 'desligar' para encerrar    ###\n")

        model = genai.GenerativeModel('gemini-pro')
        chat = model.start_chat(history=[])

        while True:
            texto = self.ouvir_comando()
            if texto.lower() == "desligar":
                break

            response = chat.send_message(texto)
            print("\n\nGemini:", response.text, "\n")
            self.falar_resposta(response.text)

        print("Encerrando Chat")


# Exemplo de uso
if __name__ == '__main__':
    chatbot = ChatbotAssistente()
    chatbot.configurar_voz()
    chatbot.iniciar_chatbot()
