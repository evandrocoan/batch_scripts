import os

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = r"../gen-lang-client-0919356485-43fd5df838f2.json"

from google.cloud import texttospeech

client = texttospeech.TextToSpeechClient()

# 1. Defina o seu texto usando tags SSML
ssml_text = """
<speak>
    Alô! É com <emphasis level="strong">muita alegria</emphasis> que!
    E <emphasis level="moderate">olha só</emphasis>: depois tem um <prosody rate="slow" pitch="-1st">delicioso</prosody> esperando por vocês!
    <prosody rate="x-fast" pitch="+2st">Não percam, esperamos vocês!</prosody>
</speak>
"""

text_input = "Some text"

audio_config = texttospeech.AudioConfig(
    pitch=1.7,           # Tom um pouco mais agudo/alegre
    speaking_rate=1.7,   # 30% mais rápido
    audio_encoding=texttospeech.AudioEncoding.LINEAR16,
)

synthesis_input = texttospeech.SynthesisInput(ssml=ssml_text)
# synthesis_input = texttospeech.SynthesisInput(text=text_input)

# 3. Selecione a voz
voice = texttospeech.VoiceSelectionParams(
    language_code="pt-BR",
    name="pt-BR-Neural2-B"
    # name="pt-BR-Chirp3-HD-Orus"
    # name="pt-BR-Wavenet-D"
    # name="pt-BR-Neural2-C"
)

# 5. Gere o áudio
response = client.synthesize_speech(
    input=synthesis_input, voice=voice, audio_config=audio_config
)

# Salve o arquivo
with open("anuncio_animado_ssml.wav", "wb") as out:
    out.write(response.audio_content)
    print('Áudio salvo no arquivo "anuncio_animado_ssml.wav"')
