import pdfplumber
import pandas as pd
import os
import zipfile

legenda = {
    "OD": "Procedimentos Odontológicos",
    "AMB": "Procedimentos Ambulatoriais"
}

pdf_path = "../TESTE DE WEB SCRAPING/downloads/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"
csv_filename = "tabela_procedimentos.csv"
zip_filename = "Teste_{Rafael_Rocha}.zip"

data = []


with pdfplumber.open(pdf_path) as pdf:
    for page in pdf.pages:
        tables = page.extract_tables()
        for table in tables:
            for row in table:
                data.append(row)

df = pd.DataFrame(data)

df.replace(legenda, inplace=True)


df.to_csv(csv_filename, index=False, header=False, encoding="utf-8")


with zipfile.ZipFile(zip_filename, "w", zipfile.ZIP_DEFLATED) as zipf:
    zipf.write(csv_filename)



print(f"Extração e compactação concluídas! O arquivo ZIP foi salvo como {zip_filename}")
