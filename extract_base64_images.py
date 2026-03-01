#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para extrair imagens Base64 embutidas em arquivos Markdown,
salvá-las como arquivos separados e gerar um Markdown limpo.

Suporta dois estilos de imagens Base64:

1. Inline: ![alt text](data:image/png;base64,CODIGO...)
2. Reference-style (com ou sem angle brackets):
     [image1]: data:image/png;base64,CODIGO...
     [image1]: <data:image/png;base64,CODIGO...>
"""

import argparse
import base64
import os
import re
import sys


def parse_args():
    """Processa os argumentos da linha de comando."""
    parser = argparse.ArgumentParser(
        description="Extrai imagens Base64 de um arquivo Markdown e salva como arquivos separados."
    )
    parser.add_argument(
        "markdown_file",
        help="Caminho para o arquivo .md contendo imagens Base64.",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Sobrescreve o arquivo original em vez de criar um novo com sufixo '_limpo'.",
    )
    parser.add_argument(
        "--images-dir",
        default="images",
        help="Subdiretório onde as imagens serão salvas (relativo ao Markdown). Padrão: 'images'.",
    )
    return parser.parse_args()


def decode_and_save(ref_id, image_type, base64_data, images_dir):
    """
    Decodifica uma string Base64, salva a imagem no disco e retorna o
    caminho relativo do arquivo salvo.

    Args:
        ref_id: Identificador da referência (usado como nome do arquivo).
        image_type: Tipo MIME da imagem (ex: png, jpeg).
        base64_data: String Base64 codificada.
        images_dir: Diretório absoluto onde a imagem será salva.

    Returns:
        Caminho relativo do arquivo salvo (ex: images/image1.png), ou None em caso de erro.
    """
    # Normaliza o tipo MIME para extensão de arquivo
    ext_map = {
        "jpeg": "jpg",
        "svg+xml": "svg",
    }
    extension = ext_map.get(image_type.lower(), image_type.lower())

    # Remove espaços e quebras de linha que possam existir no Base64
    base64_clean = re.sub(r"\s+", "", base64_data)

    # Decodifica o Base64 para bytes binários
    try:
        image_bytes = base64.b64decode(base64_clean)
    except Exception as e:
        print(f"  [ERRO] Não foi possível decodificar '{ref_id}': {e}")
        return None

    # Monta o nome do arquivo de saída (ex: image1.png)
    image_filename = f"{ref_id}.{extension}"
    image_path = os.path.join(images_dir, image_filename)

    # Cria o diretório se não existir
    os.makedirs(images_dir, exist_ok=True)

    # Salva a imagem no disco
    with open(image_path, "wb") as img_file:
        img_file.write(image_bytes)

    print(f"  Salva: {image_filename} ({len(image_bytes)} bytes)")
    return image_filename


def extract_reference_style(markdown_text, images_dir, images_rel):
    """
    Processa definições de referência com Base64 (reference-style).
    Formato esperado (com ou sem angle brackets):
        [image1]: <data:image/png;base64,iVBORw0KGgo...>
        [image1]: data:image/png;base64,iVBORw0KGgo...

    Substitui cada definição pelo caminho relativo do arquivo salvo:
        [image1]: images/image1.png

    Args:
        markdown_text: Conteúdo completo do Markdown.
        images_dir: Caminho absoluto do diretório para salvar as imagens.
        images_rel: Caminho relativo do diretório de imagens (para o Markdown).

    Returns:
        Tupla (texto_modificado, quantidade_de_imagens_extraidas).
    """
    # Regex para definições de referência com data URI Base64.
    # Suporta com e sem angle brackets < >.
    # Grupo 1: ID da referência (ex: image1)
    # Grupo 2: tipo MIME da imagem (ex: png, jpeg)
    # Grupo 3: dados Base64
    pattern = re.compile(
        r"^\[([^\]]+)\]:\s*"             # [ref_id]:  (início de linha)
        r"<?data:image/([a-zA-Z+]+);"    # <data:image/EXTENSAO;  (< opcional)
        r"base64,"                        # base64,
        r"([A-Za-z0-9+/=\s]+?)"         # CODIGO_BASE64
        r">?\s*$",                        # > opcional no final da linha
        re.MULTILINE,
    )

    count = 0

    def replacer(match):
        nonlocal count

        ref_id = match.group(1)
        image_type = match.group(2)
        base64_data = match.group(3)

        rel_path = decode_and_save(ref_id, image_type, base64_data, images_dir)
        if rel_path is None:
            return match.group(0)  # mantém o original em caso de erro

        count += 1
        # Substitui a definição pelo caminho relativo do arquivo
        return f"[{ref_id}]: {images_rel}/{rel_path}"

    new_text = pattern.sub(replacer, markdown_text)
    return new_text, count


def extract_inline_style(markdown_text, base_name, images_dir, images_rel):
    """
    Processa imagens inline com Base64.
    Formato esperado:
        ![alt text](data:image/png;base64,iVBORw0KGgo...)

    Substitui pela referência ao arquivo salvo:
        ![alt text](images/notas_img_1.png)

    Args:
        markdown_text: Conteúdo completo do Markdown.
        base_name: Nome base do arquivo para nomear as imagens.
        images_dir: Caminho absoluto do diretório para salvar as imagens.
        images_rel: Caminho relativo do diretório de imagens (para o Markdown).

    Returns:
        Tupla (texto_modificado, quantidade_de_imagens_extraidas).
    """
    # Regex para imagens inline com data URI Base64.
    # Grupo 1: alt text (pode estar vazio)
    # Grupo 2: tipo MIME da imagem (ex: png, jpeg, gif, webp)
    # Grupo 3: dados Base64
    pattern = re.compile(
        r"!\[([^\]]*)\]"                       # ![alt text]
        r"\("                                   # (
        r"data:image/([a-zA-Z+]+);"            # data:image/EXTENSAO;
        r"base64,"                              # base64,
        r"([A-Za-z0-9+/=\s]+)"                # CODIGO_BASE64
        r"\)"                                   # )
    )

    count = 0

    def replacer(match):
        nonlocal count
        count += 1

        alt_text = match.group(1)
        image_type = match.group(2)
        base64_data = match.group(3)

        ref_id = f"{base_name}_img_{count}"
        rel_path = decode_and_save(ref_id, image_type, base64_data, images_dir)
        if rel_path is None:
            count -= 1
            return match.group(0)

        return f"![{alt_text}]({images_rel}/{rel_path})"

    new_text = pattern.sub(replacer, markdown_text)
    return new_text, count


def main():
    args = parse_args()

    md_path = os.path.abspath(args.markdown_file)

    # Verifica se o arquivo existe
    if not os.path.isfile(md_path):
        print(f"Erro: arquivo não encontrado: {md_path}")
        sys.exit(1)

    # Deriva o diretório de saída e o nome base a partir do arquivo de entrada
    md_dir = os.path.dirname(md_path)
    base_name = os.path.splitext(os.path.basename(md_path))[0]

    # Diretório onde as imagens serão salvas (subpasta do diretório do Markdown)
    images_rel = args.images_dir
    images_dir = os.path.join(md_dir, images_rel)

    print(f"Processando: {md_path}")
    print(f"Imagens serão salvas em: {images_dir}")

    # Lê o conteúdo do Markdown
    with open(md_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Primeiro processa as definições reference-style (mais comum no caso do usuário)
    print("\n--- Extraindo referências (reference-style) ---")
    content, ref_count = extract_reference_style(content, images_dir, images_rel)

    # Depois processa imagens inline
    print("\n--- Extraindo imagens inline ---")
    content, inline_count = extract_inline_style(content, base_name, images_dir, images_rel)

    total = ref_count + inline_count

    if total == 0:
        print("\nNenhuma imagem Base64 encontrada no arquivo.")
        sys.exit(0)

    # Decide onde salvar o Markdown resultante
    if args.overwrite:
        output_md = md_path
    else:
        output_md = os.path.join(md_dir, f"{base_name}_limpo.md")

    with open(output_md, "w", encoding="utf-8") as f:
        f.write(content)

    print(f"\nTotal de imagens extraídas: {total} (referências: {ref_count}, inline: {inline_count})")
    print(f"Markdown salvo em: {output_md}")


if __name__ == "__main__":
    main()
